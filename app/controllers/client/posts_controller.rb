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

def new
  @post = {
    "name" => params[:name],
    "body" => params[:body],
    # "username" => params[:username],
    "main_picture" => params[:main_picture],
    "link" => params[:link]
    }
  render 'new.html.erb'
end

def create
    @post = {
      "name" => params[:name],
      "body" => params[:body],
      # "username" => current_user,
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

def edit
post_id = params[:id]
puts post_id 
response = Unirest.get("http://localhost:3000/api/posts/#{post_id}")
puts reponse 
@post = response.body
puts @post 
render 'edit.html.erb'  
end
def update
  @post = {
      "title" => params[:title],
      "body" => params[:body],
      "main_picture" => params[:main_picture],
      "link" => params[:link]
    }

    response = Unirest.patch("http://localhost:3000/api/posts/#{params[:id]}", parameters: @post)
  
    if response.code == 200
      flash[:success] = "Product updated successfully!"
      redirect_to "/client/posts/#{params[:id]}"
    else
      @errors = response.body['errors']
      render 'edit.html.erb'
    end
  end

  def destroy
    post_id = params[:id] 
    response = Unirest.delete("http://localhost:3000/api/posts/#{product_id}").body
    # render 'destroy.html.erb'
    flash[:danger] = "Post destroyed successfully!"
    redirect_to "/client/posts"
  end


