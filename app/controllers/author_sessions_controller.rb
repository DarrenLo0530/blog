class AuthorSessionsController < ApplicationController
  def new
  end

  def index
    render action: :new
  end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to(articles_path, notice: 'Logged in successfully.')
    else
      flash.now.notice = "Login failed."
      render action: :new
    end
  end

  def destroy
    logout
    flash.notice = "Logged out"
    redirect_to authors_path
  end
end
