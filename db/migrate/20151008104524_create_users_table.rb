class CreateUsersTable < ActiveRecord::Migration
  def change
  	create_table :users do |t|
  		t.string :fname
  		t.string :lname
  		t.string :email
  		t.string :username
  		t.string :password
  	end
  	create_table :posts do |t|
  		t.string :body
  		t.integer :user_id
 	end
 	create_table :profiles do |t|
 		t.string :bio
 		t.datetime :lastupdated
 	end
 	create_table :follows do |t|
 		t.integer :follower_id
 		t.integer :followee_id
 	end
  end
end
