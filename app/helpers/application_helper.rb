module ApplicationHelper

  def is_author?
    logged_in? && current_user.id == @article.author_id
  end

  def require_author
    unless is_author?
      flash.notice = "You may not access this function as you are not the owner"
      redirect_to articles_path(@article) 
    end
  end


end
