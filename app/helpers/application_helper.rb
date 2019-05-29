module ApplicationHelper
  def log_in user
    session[:user_id] = user.id
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def current_user
    return unless session[:user_id]
    @current_user ||= User.find_by id: session[:user_id]
  end

  def logged_in?
    current_user ? true : false
  end

  def current_user? user
    user == current_user
  end

  def entry_commentable? entry
    current_user.following?(entry.user) || current_user == entry.user
  end

  def authenticate_administrator
    return true if current_user&.admin?
    flash[:error] = "You don't have permission for this action!"
    redirect_to root_path
  end
end
