require "sinatra"
require "sinatra/activerecord"
require "./models"
require "sinatra/content_for"
require "sinatra/contrib/all"
require 'bundler/setup'
require "rack-flash"
require "pry"
enable :sessions

set :database, "sqlite3:ourvinyl.sqlite3"
use Rack::Flash, sweep: true
set :sessions, true
#a session allows you to associate info with each individual user of your application
#all session data is stored inside of a session hash

def current_user
	if session[:user_id]
	@current_user = User.find(session[:user_id])
	else 
	nil
	end
end



#Options to sign in, sign up, and sign out
get "/sign-in" do 
	erb :sign_in_form
end

post "/sign-in" do
	@user = User.where(email: params[:email]).first
	
	if @user && @user.password == params[:password]
		session[:user_id]=@user.id 
		flash[:notice] = "Successful Login" #to be changed
		redirect "/home"
	else
		flash[:alert] = "Incorrect Login Info" #to be changed
		redirect "/sign-in"
	end
end

post "/sign-up" do
	if User.find_by email: params[:email]  
	 	flash[:alert] = "This email address is already signed up for an account."
	 	redirect "/sign-in"
	 	#alerts if email or username is already in db
	elsif User.find_by username: params[:username]
		flash[:alert] = "That username is already in use, please select another."
		redirect "/sign-in"
	else 
	#if doesn't already exist, add info to db
		@user = User.create(email: params[:email],fname: params[:fname],lname: params[:lname],username: params[:username], password: params[:password])
		@user.profile = Profile.create(bio: params[:bio])
		@user.save
		redirect "/sign-in"
	end
end

get "/signout" do 
	session[:user_id] = nil
	flash[:notice] = "You are now signed out"
	redirect "/sign-in"
end
#end of sign in/up/out options


get "/" do
	redirect "/home"
end

#Home Route is the page where users can post and see all users' posts
get "/home" do
	if session[:user_id]
		@posts = Post.limit(10).order(created_at: :desc)
		erb :home
	else
	flash[:alert] = "You must be logged in to view recent Humms"
	redirect "/sign-in"
	end		
end

post "/hummery" do
	Post.create(body: params[:boxy], user_id: session[:user_id])
	redirect "/home"
end
#end of Home routes



get "/profile" do
  @posts = Post.where(user_id: session[:user_id]).order(created_at: :desc)
  @user = User.find(session[:user_id])

  erb :profile
end

get "/allhumms" do
	@posts = Post.order(created_at: :desc).all
	erb :allhums
end
##########


get "/users_all" do
	@users = User.all
	erb :users
end

get "/users/:id/posts" do
@posts = Post.where(user_id: params[:id]).order(created_at: :desc)

@user = User.where(id: params[:id]).first
# binding.pry
erb :profile
end



# 	@thisuser = User.where(user)

# get "/users/:id/posts" do
# 	@user = User.find(params[:id])

# 	#whatever page you want it to load, ex
# 	erb :home
# end



get "/followees" do
	@current_user = User.find(session[:user_id])
	@users = current_user.followees
	erb :users
end

get "/followers" do
	@current_user = User.find(session[:user_id])
	@users = @current_user.followers
	erb :followers
end

get "/users/:followee_id/follow" do
	Follow.create(follower_id: session[:user_id], followee_id: params[:followee_id])
	redirect "/users/all"
end

get "/users/:followee_id/unfollow" do
	@follow = Follow.where(follower_id: session[:user_id], followee_id: params[:followee_id]).first
	@follow.destroy
	redirect "/users/all"
end




#Settings Page (options to update and delete)
get "/settings" do 
	erb :settings
end

 
post "/update_my_account" do
	@user_id = User.find(session[:user_id]).id
	@profile_id = Profile.where(user_id: session[:user_id])
	if (params[:newusername] != "")
	User.update(@user_id, username:params[:newusername])
	end
	if (params[:newpassword] != "")
	User.update(@user_id, password: params[:newpassword])
	end
	if (params[:newbio] != "")
	Profile.update(@profile_id, bio: params[:newbio])
	end
	flash[:notice] = "You have successfully updated your account information."
	redirect "/home"
end


get "/delete_account" do
	@myaccount = User.find(session[:user_id])
	@posts = Post.where(user_id: session[:user_id]).all
	@posts.destroy_all
	@myaccount.destroy
	flash[:alert] = "You have deleted your Humm account :("
	redirect "/sign-in"
end
#end of settings page





