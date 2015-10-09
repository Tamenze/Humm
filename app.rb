require "sinatra"
require "sinatra/activerecord"
require "./models"


set :database, "sqlite3:ourvinyl.sqlite3"
enable :sessions

get "/" do
	if session[:user_id]
		@user = User.find(session[:user_id])
	end
	erb :home
end


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

	redirect "/"
end

post "/sign-up" do
	@user = User.new(:email=> params[:email],:fname=> params[:fname], :lname=>params[:lname], :username=>params[:username],:password=>params[:password])

		if   #doesn't already exist, add info
		#to database
		else 
		flash[:alert] = "Nooooo" to 
		end 
end

# =>  include option to sign up