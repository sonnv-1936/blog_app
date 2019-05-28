class EntriesController < ApplicationController
  attr_reader :entry

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

  private

  def entry_params
    params.require(:entry).permit :title, :body
  end
end
