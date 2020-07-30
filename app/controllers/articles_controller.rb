class ArticlesController < ApplicationController
  include ArticlesHelper
  include ApplicationHelper

  before_action :require_login, except: [:index, :show]
  before_action :set_article, except: [:index, :create, :new]
  before_action :require_author, only: [:destroy, :edit]

  def index
    if(params[:ranked] == 'true')
      @articles = Article.order(view_count: :desc).limit(5)
    else
      @articles = Article.all
    end
  end

  def show
    @article.add_visit
    @comment = Comment.new
    @comment.article_id = @article.id
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.author_id = current_user.id
    @article.view_count = 0
    if @article.save
      flash.notice = "Created article: '#{@article.title}'"
      redirect_to article_path(@article);
    else 
      render :new
    end
  end

  def destroy
    flash.notice = "Deleted article: '#{@article.title}'"
    @article.destroy

    #Deletes tag from database if no more articles are using the tag
    helpers.remove_unused_tags

    redirect_to articles_path
  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash.notice = "Updated the article"
      redirect_to article_path(@article)
    else
      render :edit
    end

    helpers.remove_unused_tags
  end

end
