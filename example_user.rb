class User
    attr_accessor :name, :email # 为用户名和邮箱创建存取方法 @开头 实例变量

    def initialize(attributes = {})  # 定义方法initialize 执行User.new 会调用这个 ，接受一个参数 空散列
       @name = attributes[:name]
       @email = attributes[:email]
    end

    def formatted_email        # 定义方法。变量插值，
        "#{@name} <#{@email}>"
    end
end