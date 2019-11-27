require "report.rb"
require "date"

class ReportsController < ApplicationController
    before_action :authenticate_user, {only: [:index,:new_form,:new_recheck,:new,:display,:student_list,:chargedList,:check_form,:check_recheck,:check,:anAuthedList,:update_form,:update,:update_recheck,:serach_form,:search_result]}
    before_action :forbid_login_user, {only: []}
    before_action :admin_user_only,{only: []}
    before_action :student_user_only,{only: [:new_form,:new_recheck,:new,:student_list,:anAuthedList,:update_form,:update,:update_recheck]}
    before_action :teacher_user_only,{only: [:chargedList,:check_form,:check_recheck,:check]}

    def index

    end

    def new_form
        @report = Report.new
    end

    def new_recheck
        @hash_method = Report.new.getHashMethod()
        @hash_content = Report.new.getHashContent()
        @hash_detail = Report.new.getHashDetail()
        @hash_grade = Report.new.getHashGrade()
        @hash_notice = Report.new.getHashNotice()
        @hash_result = Report.new.getHashResult()

        @report = Report.new(
            com_name: params[:com_name],
            exam_date: params[:exam_date],
            exam_place: params[:exam_place],
            exam_grade: params[:exam_grade],
            notice_method: params[:notice_method],
            exam_method: Report.new.checkboxToArray(params[:exam_method]),
            exam_content: Report.new.checkboxToArray(params[:exam_content]),
            exam_detail: Report.new.checkboxToArray(params[:exam_detail]),
            free_comment: params[:free_comment],
            result: params[:result]
        )
        render :new_form if @report.invalid?
    end

    def new
        @report = Report.new(
            com_name: params[:com_name],
            exam_date: params[:exam_date],
            exam_place: params[:exam_place],
            exam_grade: params[:exam_grade],
            notice_method: params[:notice_method],
            exam_method: params[:exam_method],
            exam_content: params[:exam_content],
            exam_detail: params[:exam_detail],
            free_comment: params[:free_comment],
            result: params[:result],
            student_id: @current_user.user_id,
            teacher_id: @current_user.teacher_id,
            auth_flag: "0",
            report_date: Date.today
        )
        if @report.save
            flash[:notice] = "送信が完了しました"
            redirect_to("/")
        else
            flash[:notice] = "登録内容に問題があります"
            render("reports/new_form")
        end
    end

    def display
        @report = Report.find_by(id: params[:id])
        @hash_method = Report.new.getHashMethod()
        @hash_content = Report.new.getHashContent()
        @hash_detail = Report.new.getHashDetail()
        @hash_grade = Report.new.getHashGrade()
        @hash_notice = Report.new.getHashNotice()
        @hash_result = Report.new.getHashResult()
    end

    def student_list
        @reports = Report.where(student_id: @current_user.user_id).order(report_date: "ASC")
        @hash_grade = Report.new.getHashGrade()
    end

    def chargedList
        @reports = Report.where(teacher_id: @current_user.user_id).order(report_date: "ASC")
        @students = User.where(role: "student")
        @hash_grade = Report.new.getHashGrade()
    end

    def check_form
        @hash_method = Report.new.getHashMethod()
        @hash_content = Report.new.getHashContent()
        @hash_detail = Report.new.getHashDetail()
        @hash_grade = Report.new.getHashGrade()
        @hash_notice = Report.new.getHashNotice()
        @hash_result = Report.new.getHashResult()
        @report = Report.find_by(id: params[:id])
        @student = User.find_by(user_id: @report.student_id)
    end

    def check_recheck
        @hash_method = Report.new.getHashMethod()
        @hash_content = Report.new.getHashContent()
        @hash_detail = Report.new.getHashDetail()
        @hash_grade = Report.new.getHashGrade()
        @hash_notice = Report.new.getHashNotice()
        @hash_result = Report.new.getHashResult()
        @hash_auth = {"1": "仮承認　(試験後に再提出)","2": "承　認　(公開)","3": "未承認　(再提出が必要)"}

        @report = Report.find_by(id: params[:id])
        @report.auth_flag = params[:auth_flag]
        @report.teached_comment = params[:teached_comment]
        @student = User.find_by(user_id: @report.student_id)
        render :check_form if @report.invalid?
    end

    def check
        @report = Report.find_by(id: params[:id])
        @report.auth_flag = params[:auth_flag]
        @report.teached_comment = params[:teached_comment]
        @report.due_date = params[:due_date]
        if @report.save
            flash[:notice] = "完了しました"
            # メール関係のモジュール

            redirect_to("/report/chargedList")
        else
            flash[:notice] = "登録内容に問題があります"
            render :check_form
        end
    end

    def anAuthedList
        @reports = Report.where(student_id: @current_user.user_id).order(report_date: "ASC")
        @hash_grade = Report.new.getHashGrade()
    end

    def update_form
        @report = Report.find_by(id: params[:id])
    end

    def update_recheck
        @hash_method = Report.new.getHashMethod()
        @hash_content = Report.new.getHashContent()
        @hash_detail = Report.new.getHashDetail()
        @hash_grade = Report.new.getHashGrade()
        @hash_notice = Report.new.getHashNotice()
        @hash_result = Report.new.getHashResult()

        @report = Report.find_by(id: params[:id])
        @report.com_name = params[:com_name]
        @report.exam_date = params[:exam_date]
        @report.exam_place = params[:exam_place]
        @report.exam_grade = params[:exam_grade]
        @report.notice_method =  params[:notice_method]
        @report.exam_method =  Report.new.checkboxToArray(params[:exam_method])
        @report.exam_content =  Report.new.checkboxToArray(params[:exam_content])
        @report.exam_detail =  Report.new.checkboxToArray(params[:exam_detail])
        @report.free_comment =  params[:free_comment]
        @report.result = params[:result]
        render :update_form if @report.invalid?
    end

    def update
        @report = Report.find_by(id: params[:id])
        @report.com_name = params[:com_name]
        @report.exam_date = params[:exam_date]
        @report.exam_place = params[:exam_place]
        @report.exam_grade = params[:exam_grade]
        @report.notice_method = params[:notice_method]
        @report.exam_method = params[:exam_method]
        @report.exam_content = params[:exam_content]
        @report.exam_detail = params[:exam_detail]
        @report.free_comment = params[:free_comment]
        @report.result = params[:result]
        @report.student_id = @current_user.user_id
        @report.teacher_id = @current_user.teacher_id
        @report.auth_flag = "0"
        @report.report_date = Date.today

        if @report.save
            flash[:notice] = "送信が完了しました"
            redirect_to("/report/update/list")
        else
            flash[:notice] = "登録内容に問題があります"
            render :update_form
        end
    end

    def serach_form
    end

    def search_result
        @hash_grade = Report.new.getHashGrade()
        @hash_result = Report.new.getHashResult()

        contentArray = Report.new.checkboxToArray(params[:exam_content])
        detailArray = Report.new.checkboxToArray(params[:exam_detail])
        @reports = Report.where(auth_flag: "2")
        @reports = @reports.where("com_name LIKE ?", "%#{params[:com_name]}%") if params[:com_name].present?
        contentArray.split(",").each do |content|
            @reports = @reports.where("exam_content LIKE ?", "%#{content}%")
        end
        detailArray.split(",").each do |detail|
            @reports = @reports.where("exam_detail LIKE ?", "%#{detail}%")
        end
        @reports = @reports.where("exam_grade LIKE ?", "%#{params[:exam_grade]}%") if params[:exam_grade].present?
    end
end
