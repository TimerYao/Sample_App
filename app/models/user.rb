class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token
    # before_save { self.email = email.downcase }
    before_save :downcase_email
    before_create :create_activation_digest
    validates :name, presence: true, length: { maximum: 50 }
    # validates(:name, presence: true)
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
               format: { with: VALID_EMAIL_REGEX },
               uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

    # 返回指定字符串的哈希摘要
    def self.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end


    # 返回记忆令牌 随机的
    def self.new_token
        SecureRandom.urlsafe_base64
    end
    # 为了持久保存会话，在数据库中记住用户
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # 比较摘要和令牌，如果指定令牌和摘要匹配。返回true
    def authenticated?(remember_token)
        return false if(remember_digest.nil?)
        # 如果记忆摘要为空 返回false
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    #  忘记用户
    def forget
        update_attribute(:remember_digest, nil)
    end

    private
      #    电子邮箱转换为小写
    def downcase_email
        # self.email = email.downcase
        email.downcase!
    end 
    # 创建并赋值激活令牌和摘要
    def create_activation_digest
        self.activation_token = User.new_token
        self.activation_digest = User.digest(activation_token)
    end
end
