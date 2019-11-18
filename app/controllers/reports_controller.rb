class ReportsController < ApplicationController
    before_action :authenticate_user, {only: [:index]}
    before_action :forbid_login_user, {only: []}

    def index

    end
end
