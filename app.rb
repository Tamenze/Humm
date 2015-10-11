require "sinatra"
require "sinatra/activerecord"
# require "./models"


set :database, "sqlite3:ourvinyl.sqlite3"



# get "/sign-in" do 
# 	erb :sign_in_form
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