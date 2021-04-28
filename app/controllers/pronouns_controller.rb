class PronounsController < ApplicationController


  before_action :load_pronoun, only: [:show, :edit, :update, :destroy]
  helper :hot_glue
  include HotGlue::ControllerHelper


  # TODO: implement current_user or use Devise


  


  def load_pronoun
    @pronoun = Pronoun.find(params[:id])
  end
  

  def load_all_pronouns
    @pronouns = Pronoun.page(params[:page])
    
  end

  def index
    load_all_pronouns
    respond_to do |format|
       format.html
    end
  end

  def new 
    @pronoun = Pronoun.new
   
    respond_to do |format|
      format.html
    end
  end

  def create
    modified_params = modify_date_inputs_on_params(pronoun_params.dup )
    @pronoun = Pronoun.create(modified_params)

    if @pronoun.save
      flash[:notice] = "Successfully created #{@pronoun.name}"
      load_all_pronouns
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to pronouns_path }
      end
    else
      flash[:alert] = "Oops, your pronoun could not be created."
      respond_to do |format|
        format.turbo_stream
        format.html
      end
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def update
    if @pronoun.update(modify_date_inputs_on_params(pronoun_params))
      flash[:notice] = "Saved #{@pronoun.name}"
    else
      flash[:alert] = "Pronoun could not be saved."
    end
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def destroy
    begin
      @pronoun.destroy
    rescue StandardError => e
      flash[:alert] = "Pronoun could not be deleted"
    end
    load_all_pronouns
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to pronouns_path }
    end
  end

  def pronoun_params
    params.require(:pronoun).permit( [:name] )
  end

  def default_colspan
    1
  end

  def namespace
    
      ""
    
  end


  def common_scope
    @nested_args
  end

end


