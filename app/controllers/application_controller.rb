class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :set_current_user

    def set_current_user
        @current_user = User.find_by(user_id: session[:user_id])
    end

    def authenticate_user
        if @current_user == nil
        flash[:notice] = "ログインが必要です"
        redirect_to("/login")
        end
    end

    def forbid_login_user
        if @current_user
        flash[:notice] = "すでにログインしています"
        redirect_to("/index")
        end
    end

    def admin_user_only
        if @current_user.role != "admin"
            flash[:notice] = "不正なアクセスです"
            redirect_to("/index")
        end
    end
end
