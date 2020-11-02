class DashboardController < ApplicationController
    before_action :authenticate_user!
    def index
        @secure_passwords = SecurePassword.where(:user_id => current_user.id)
    end
end
