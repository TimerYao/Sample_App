module SessionsHelper
    # login 指定用户
    def log_in(user)
        session[:user_id] = user.id
    end

    #  记住用户
    def remember(user)
        user.remember
        cookies.permanent.signed[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
    end

     #返回当前登录的用户
    def current_user?(user)
       user == current_user
    end

    #signed`方法默认既签名也加密。permanent 持久存储
    # 返回 cookie 中记忆令牌对应的用户
    def current_user
        if (user_id = session[:user_id])
            @current_user ||= User.find_by(id: user_id)
            # 如果会话中有用户id 就赋值给user_id,否则则跳转登录
        elsif (user_id = cookies.signed[:user_id])
            user = User.find_by(id: user_id)
            if user && user.authenticated?(:remember, cookies[:remember_token])
                log_in user
                @current_user = user
            end
        end
    end
   

    # 已登录返回true else false

    def logged_in?
        !current_user.nil?
    end

    # 忘记持久会话

    def forget(user)
        user.forget
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
    end

    # 退出
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end

    # 重定向到存储地址或者默认地址
    def redirect_back_or(defalut)
        redirect_to(session[:forwarding_url] || defalut)
        session.delete(:forwarding_url)
    end
    # 存储后面需要用的地址
    def store_location
        session[:forwarding_url] = request.original_url if request.get?
    end
end
