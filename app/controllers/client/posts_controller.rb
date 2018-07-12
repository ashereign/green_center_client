class Client::PostsController < ApplicationController

  def index
    client_params = {
      search: params[:search],
      topic: params[:topic]
    }

    response = Unirest.get("http://localhost:3000/api/posts", parameters: client_params)
    @posts = response.body
    render "index.html.erb"
  end

def show
  post_id = params[:id]
  response = Unirest.get("http://localhost:3000/api/posts/#{post_id}")
  @post = response.body
  render 'show.html.erb'
end

def create
    @post = {
      "name" => params[:name],
      "body" => params[:body],
      "username" => current_user,
      "main_picture" => params[:main_picture],
      "link" => params[:link],
    }

    response = Unirest.post("http://localhost:3000/api/posts", parameters: @post)
    # render 'create.html.erb'
    #flash needs to happen before redirect
  if response.code == 200
    flash[:success] = "Product created successfully!"

    redirect_to "/client/posts/"
  else
      @errors = response.body['errors']
      render 'new.html.erb'
  end
    # redirect are always get requests
end



end
