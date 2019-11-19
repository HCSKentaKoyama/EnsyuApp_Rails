require "report.rb"

class UsersController < ApplicationController
    before_action :authenticate_user, {only: [:logout,:createStudent,:createStudent_form,:createTeacher,:createTeacher_form,:update_form,:update,:chargedStudent_list,:student_info]}
    before_action :forbid_login_user, {only: [:login_form, :login]}
    before_action :admin_user_only,{only: [:createStudent,:createStudent_form,:createTeacher,:createTeacher_form]}

    def login_form
        @user = User.new
    end

    def login
        @user = User.find_by(user_id: params[:user_id])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.user_id
            if (@user.mail == nil) && (@user.role == "student" || @user.role == "teacher")
                redirect_to("/update")
            else
                flash[:notice] = "ログインしました"
                redirect_to("/index")
            end
        else
            flash[:notice] = "ユーザIDまたはパスワードが間違っています"
            @user_id = params[:user_id]
            @password = params[:password]
            render("users/login_form")
        end
    end

    def logout
        session[:user_id] = nil
        flash[:notice] = "ログアウトしました"
        redirect_to("/login")
    end

    def createStudent_form
        @user = User.new
    end

    def createTeacher_form
        @user = User.new
    end

    def createStudent
        @user = User.new(
            user_id: params[:user_id],
            password: params[:password],
            name: params[:name],
            class_number: params[:class_number],
            teacher_id: params[:teacher_id],
            role: "student"
        )
        if @user.save
            flash[:notice] = "学生登録が完了"
            redirect_to("/index")
        else
            flash[:notice] = "登録内容に問題があります"
            @user_id = params[:user_id]
            @password = params[:password]
            @name = params[:name]
            @class_number = params[:class_number]
            @teacher_id = params[:teacher_id]
            render("users/createStudent_form")
        end
    end

    def createTeacher
        @user = User.new(
            user_id: params[:user_id],
            password: params[:password],
            name: params[:name],
            role: "teacher"
        )
        if @user.save
            flash[:notice] = "教員登録が完了"
            redirect_to("/index")
        else
            flash[:notice] = "登録内容に問題があります"
            @user_id = params[:user_id]
            @password = params[:password]
            @name = params[:name]
            render("users/createTeacher_form")
        end
    end

    def update_form
        @user = User.find_by(user_id: @current_user.user_id)
        if (@user.mail == nil) && (@user.role == "student" || @user.role == "teacher")
            flash[:notice] = "メールアドレスを登録してください"
        end
        @mail = @user.mail
        @password = @user.password
    end

    def update
        @user = User.find_by(user_id: @current_user.user_id)
        @user.mail = params[:mail]
        @user.password = params[:password]
        if @user.save
            flash[:notice] = "更新しました"
            redirect_to("/index")
        else
            flash[:notice] = "更新内容に問題があります"
            @mail = params[:mail]
            render("users/update")
        end
    end

    def chargedStudent_list
        @users = User.where(teacher_id: @current_user.user_id).order(user_id: "ASC")
    end

    def student_info
        @student = User.find_by(user_id: params[:id])
        @teacher = User.find_by(user_id: @student.teacher_id)
        @reports = Report.where(student_id: @student.user_id).order(report_date: "ASC")
        @hash_grade = Report.new.getHashGrade()
    end
end
