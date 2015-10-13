class User < ActiveRecord::Base
	has_many :posts
	has_one :profile
	has_many :follows, foreign_key: :followee_id
	has_many :followings, foreign_key: :follower_id, class_name: "::Follow"
	has_many :followers, through: :follows, class_name: User #active
	has_many :followees, through: :followings, class_name: User #passive
end

# https://github.com/orlandocaraballo/wdi-fall-2015-nyc/blob/master/examples-from-class/oct-10/models.rb 

class Post < ActiveRecord::Base
	belongs_to :user
end

class Profile < ActiveRecord::Base
	belongs_to :user
end

class Follow < ActiveRecord::Base 
	belongs_to :follower, foreign_key: :follower_id, class_name: "User"
	belongs_to :followee, foreign_key: :followee_id, class_name: "User"
end