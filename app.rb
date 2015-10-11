require "sinatra"
require "sinatra/activerecord"
require "./models"
require "sinatra/content_for"
require "sinatra/contrib/all"
require 'bundler/setup'
require "rack-flash"

set :database, "sqlite3:ourvinyl.sqlite3"
enable :sessions
use Rack::Flash, sweep: true
set :sessions, true


#a session allows you to associate info with each individual user of your application
#all session data is stored inside of a session hash


get "/sign-in" do 
	erb :sign_in_form
end

post "/sign-in" do
	@user = User.where(email: params[:email]).first
	
	if @user && user.password == params[:password]
		session[:user_id]=@user.id 
		flash[:notice] = "Yuppppppp" #to be changed
	else
		flash[:alert] = "Nooooope" #to be changed
	end
	redirect to "/"
	erb :home
end

# option to sign up
post "/sign-up" do
	if User.find_by email: params[:email]  
	 	flash[:alert] = "This email address is already signed up for an account."
	 	#alerts if email or username is already in db
	elsif User.find_by username: params[:username]
		flash[:alert] = "That username is already in use, please select another."
	else 
	#if doesn't already exist, add info to db
		User.create(email: params[:email],fname: params[:fname], lname: params[:lname], username: params[:username],password: params[:password])
	end
	erb :sign_in_form
end



get "/" do
	if session[:user_id]
		@current_user = User.find(session[:user_id])
	end
	erb :home
end
  


# get "/home" do
# 	@user = User.find(session[:user_id])
# 	@posts = Post.all
# 	erb :home
# end

post "/hummery" do
	Post.create(body: params[:textbox])
	@posts = Post.all
	redirect to "/"
end
# get "/public" do
# 	if session[:user_id]
# 			@posts = Post.all
# 	erb :public
# 	else
# 	flash[:alert] = "Please create an account to view these hums."
# 	end
# end



	# if @posts.body.length >= 150
	


	# flash[:alert]= "Your post must be less than 150 characters!"	
	# else 
	# Post.create(post: params[:textbox])
	# end

# get "/users/:id/posts" do
# 	@user = User.find(params[:id])

# 	#whatever page you want it to load, ex
# 	erb :home
# end

#  listing all users 
# get "/users" do
# 	@users = User.all
# end

# =>  include option to sign up

get "/home" do 
	erb :home
end

get "/settings" do 
	erb :settings
end

get "/profile" do
	erb :profile
end
# on a specific page, you would put the following in: 
# 	<% content_for :title, "this is the user title" %>
# 	how you change the title for each page...???  

# # 	--> in layout.erb, in title you would put 
# 	<title><%= yield_content :title %></title>

# # ORRR IF YOU WANTED TO SET IT SO THERE WAS A DEFAULT TITLE FOR THOSE PAGES WITHOUT LINES 72-74, YOU WOULD PUT THE BELOW WITHIN THE TITLE TAG ON LAYOUT.ERB 
# # <%  if content_for?(:title) %>
# # 	<%= yield_content :title %>
# # else
# # 	Some title here 
# # <% end %>

# #same concept for javascript 
# <% yield_content :js %> 

