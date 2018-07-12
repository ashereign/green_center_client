class Client::UsersController < ApplicationController

  def new
    render 'new.html.erb'
  end

  def create
    client_params = {
      name: params[:name],
      email: params[:email],
      username: params[:username],
      avatar: params[:avatar],
      password: params[:password],
      password_confirmation: params[:password_confirmation]
      }

    response = Unirest.post(
    "http://localhost:3000/api/users",
    parameters: client_params
    )
    
    if response.code == 200
      session[:user_id] = response.body["id"]
      flash[:success] = 'Successfully created account!'
      redirect_to '/'
    else
      flash[:warning] = 'Invalid email or password!'
      redirect_to '/client/signup'
    end
  end
end
