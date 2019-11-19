require "report.rb"
require "date"

class ReportsController < ApplicationController
    before_action :authenticate_user, {only: [:index]}
    before_action :forbid_login_user, {only: []}

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
end
