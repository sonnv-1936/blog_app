class UsersController < ApplicationController
  attr_reader :user

  before_action :find_user, only: %i(show destroy)
  before_action :authenticate_administrator, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if user.save
      log_in user
      flash[:success] = "You have signed up successfully!"
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    if params[:page] == "0" || params[:page] == "1" || params[:page] == nil
      page = 0
    else
      page = params[:page]
    end
    @user_entries = user.entries.latest.limit(5)
      .offset((page.to_i > 1 ? page.to_i - 1 : page.to_i) * 5)
    total_entries = user.entries.size
    @user_entries_pages = total_entries % 5 == 0 ? total_entries / 5 : total_entries / 5 + 1
  end

  def following_entries
    if params[:page] == "0" || params[:page] == "1" || params[:page] == nil
      page = 0
    else
      page = params[:page]
    end
    @entries = current_user.following_entries.latest.limit(5)
      .offset((page.to_i > 1 ? page.to_i - 1 : page.to_i) * 5)
    total_entries = current_user.following_entries.size
    @total_pages = total_entries % 5 == 0 ? total_entries / 5 : total_entries / 5 + 1
    render "entries/index"
  end

  def destroy
    user.destroy
    redirect_back fallback_location: root_path
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:user_id]
  end
end
