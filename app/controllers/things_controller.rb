class ThingsController < ApplicationController


  before_action :load_thing, only: [:show, :edit, :update, :destroy]
  helper :hot_glue
  include HotGlue::ControllerHelper


  # TODO: implement current_user or use Devise


  


  def load_thing
    @thing = Thing.find(params[:id])
  end
  

  def load_all_things
    @things = Thing.page(params[:page])
    
  end

  def index
    load_all_things
    respond_to do |format|
       format.html
    end
  end

  def new 
    @thing = Thing.new
   
    respond_to do |format|
      format.html
    end
  end

  def create
    modified_params = modify_date_inputs_on_params(thing_params.dup )
    @thing = Thing.create(modified_params)

    if @thing.save
      flash[:notice] = "Successfully created #{@thing.name}"
      load_all_things
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to things_path }
      end
    else
      flash[:alert] = "Oops, your thing could not be created."
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
    if @thing.update(modify_date_inputs_on_params(thing_params))
      flash[:notice] = "Saved #{@thing.name}"
    else
      flash[:alert] = "Thing could not be saved."
    end
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  def destroy
    begin
      @thing.destroy
    rescue StandardError => e
      flash[:alert] = "Thing could not be deleted"
    end
    load_all_things
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to things_path }
    end
  end

  def thing_params
    params.require(:thing).permit( [:name, :age, :pronoun_id] )
  end

  def default_colspan
    3
  end

  def namespace
    
      ""
    
  end


  def common_scope
    @nested_args
  end

end


