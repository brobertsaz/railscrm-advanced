class NotesController < ApplicationController

  def new
    @note = Note.new
    redirect_to :back
  end

  def create
    @lead = Lead.find(params[:lead_id])
    @note = @lead.notes.create(params[:note])
    if @note.save
      flash[:notice] = 'Note was successfully created'
      redirect_to @lead
    else
      flash[:error] = 'Unable to create new note'
      redirect_to @lead
    end
  end

  def edit
    @lead = Lead.find(params[:lead_id])
    @note = Note.find(params[:id])
    redirect_to :back
  end

  def destroy
    @lead = Lead.find(params[:lead_id])
    @note = Note.find(params[:id])
    if @note.destroy
      flash[:notice] = 'Note was successfully deleted'
      redirect_to @lead
    else
      flash[:error] = 'Unable to delete note'
      redirect_to @lead
    end
  end

end
