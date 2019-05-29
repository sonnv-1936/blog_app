class AdminsController < ApplicationController
  before_action :authenticate_administrator

  def index
    users = User.all
    entries = Entry.latest
    comments = Comment.all
    @manageables = [] << users << entries << comments
  end
end
