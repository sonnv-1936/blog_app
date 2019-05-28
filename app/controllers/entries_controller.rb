class EntriesController < ApplicationController
  attr_reader :entry

  def index
    @entries = Entry.all
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
