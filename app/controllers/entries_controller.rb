class EntriesController < ApplicationController
  attr_reader :entry

  before_action :find_entry, only: %i(show destroy)
  before_action :authenticate_administrator, only: :destroy

  def index
    if params[:page] == "0" || params[:page] == "1" || params[:page] == nil
      page = 0
    else
      page = params[:page]
    end
    @entries = Entry.latest.limit(5)
      .offset((page.to_i > 1 ? page.to_i - 1 : page.to_i) * 5)
    total_entries = Entry.all.size
    @total_pages = total_entries % 5 == 0 ? total_entries / 5 : total_entries / 5 + 1
  end

  def show
    @comment = entry.comments.build
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.build entry_params
    if entry.save
      flash[:success] = "Entry created successfully!"
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    entry.destroy
    redirect_back fallback_location: root_path
  end

  private

  def entry_params
    params.require(:entry).permit :title, :body
  end

  def find_entry
    @entry = Entry.find_by id: params[:entry_id]
  end
end
