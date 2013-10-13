class ContactFormsController < ApplicationController

  def new
    @contact_form = ContactForm.new
    @request_types = ['Question', 'Need Help', 'More Information', 'Suggestion']
  end

  def create
    begin
      @contact_form = ContactForm.new(params[:contact_form])
      if @contact_form.deliver
        redirect_to root_path
        flash[:notice] = 'Thank you for your message!'
      else
        render :new
      end
    rescue ScriptError
      flash[:error] = 'Sorry, this message appears to be spam and was not delivered.'
    end
  end
end
