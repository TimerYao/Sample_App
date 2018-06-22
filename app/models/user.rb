class User < ApplicationRecord
    has_many :microposts, dependent: :destroy
    has_many :active_relationships,class_name: "Relationship",
             foreign_key: "follower_id",
             dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship",
              foreign_key: "followed_id", dependent: :destroy

    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower

    # 删除用户也删除微博
    attr_accessor :remember_token, :activation_token, :reset_token
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
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        # 如果记忆摘要为空 返回false
        BCrypt::Password.new(digest).is_password?(token)
    end

    #  忘记用户
    def forget
        update_attribute(:remember_digest, nil)
    end

    # 激活账户
    def activate
        # update_attribute(:activated, true)
        # update_attribute(:activated_at, Time.zone.now)
        update_columns(activated: true,activated_at: Time.zone.now)
    end
    # 发送激活邮箱
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end
    # 设置密码重置s相关属性
    def create_reset_digest
        self.reset_token = User.new_token
        # update_attribute(:reset_digest, User.digest(reset_token))
        # update_attribute(:reset_sent_at, Time.zone.now)
        update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)

    end

    # 密码重置发送邮件

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

     # 密码请求过期 返回true
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    # 动态流原型
    def feed
        # Micropost.where("user_id= ?",id)
        # Micropost.where("user_id IN (?) or user_id = ?", following_ids, id)
        following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
        Micropost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
        # Micropost.where("user_id IN (:following_ids) OR user_id = :user_id", following_ids: following_ids, user_id: id)
    end

    # 关注另一个用户
    def follow(other_user)
        following << other_user
    end

     # 取消关注另一个用户
    def unfollow(other_user)
        following.delete(other_user)
    end

    # 如果当前用户关注了另一个用户，返回true
    def following?(other_user)
        following.include?(other_user)
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
