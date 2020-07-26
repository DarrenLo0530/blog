class ArticlesController < ApplicationController
  include ArticlesHelper
  include ApplicationHelper

  before_action :require_login, except: [:index, :show]
  before_action :set_article, except: [:index, :create, :new]
  before_action :require_author, only: [:destroy, :edit]

  def index
    @articles = Article.all
  end

  def show
    @comment = Comment.new
    @comment.article_id = @article.id
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.author_id = current_user.id
    @article.save
    flash.notice = "Created article: '#{@article.title}'"
    redirect_to article_path(@article);
  end

  def destroy
    flash.notice = "Deleted article: '#{@article.title}'"
    @article.destroy

    #Deletes tag from database if no more articles are using the tag
    helpers.remove_unused_tags

    redirect_to articles_path
  end

  def edit
    helpers.remove_unused_tags
  end

  def update
    @article.update(article_params)

    flash.notice = "Updated title to'#{@article.title}'"
    redirect_to article_path(@article)
  end

end
