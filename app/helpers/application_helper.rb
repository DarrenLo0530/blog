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

  def is_valid_date?(date_string)
    false unless date_string.present?
    begin 
      DateTime.strptime(date_string, "%Y-%m")
      true
    rescue
      false
    end
  end
end
