class UsersController < ApplicationController
    before_action :authenticate_user, {only: [:createStudent,:createStudent_form,:createTeacher,:createTeacher_form]}
    before_action :forbid_login_user, {only: [:login_form, :login]}

    def login_form
        @user = User.new
    end

    def login
        @user = User.find_by(user_id: params[:user_id])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.user_id
            flash[:notice] = "ログインしました"
            redirect_to("/index")
        else
            flash[:notice] = "ユーザIDまたはパスワードが間違っています"
            @userid = params[:user_id]
            @password = params[:password]
            render("users/login_form")
        end
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

end
