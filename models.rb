class User < ActiveRecord::Base
	has_many :posts
	has_one :profile
	has_many :follows, foreign_key: :followee_id
end

class Post < ActiveRecord::Base
	belongs_to :user
end

class Profile < ActiveRecord::Base
	belongs_to :user
end

class Follow < ActiveRecord::Base 
	belongs_to :user, foreign_key: :follower_id
end