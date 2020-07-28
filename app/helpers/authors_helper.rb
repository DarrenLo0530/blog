module AuthorsHelper
  def require_is_author
    unless current_user == @author
      flash.notice = "You can not modify an account that is not yours!"
      redirect_to root_path
    end
  end
end
