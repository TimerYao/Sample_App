module SessionsHelper
    # login 指定用户
    def log_in(user)
        session[:user_id] = user.id
    end

    # 返回当前登录的用户
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    # 已登录返回true else false

    def logged_in?
        !current_user.nil?
    end

    def log_out
        session.delete(:user_id)
        @current_user = nil
    end
end
