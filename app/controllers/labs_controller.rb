class LabsController < ApplicationController

  before_filter :require_login, except: [:index, :map, :show, :mapdata]

  # authorize_actions_for Lab, actions: { map: :read, manage_admins: :update}

  def map
    @labs = Lab.with_approved_state
  end

  def mapdata
    @labs = Lab.with_approved_state.select(:id, :name, :slug, :latitude, :longitude)
    render json: @labs, each_serializer: MapSerializer
  end

  def index
    if params[:country]
      params["country"].downcase!
    end
    all_labs = Lab.includes(:links).search_for(params[:query]).with_approved_state
    @countries = Lab.country_list_for all_labs
    @count = all_labs.size
    @labs = all_labs.order('LOWER(name) ASC').in_country_code(params["country"]).page(params['page']).per(params['per'])

    respond_to do |format|
      format.html
      format.json { render json: @labs }
      # format.csv { send_data @labs.to_csv }
    end
  end

  def new
    @lab = current_user.created_labs.build
    @lab.employees.build
    @lab.links.build
    authorize_action_for @lab
  end

  def create
    @lab = current_user.created_labs.build lab_params
    @lab.employees.first.assign_attributes(user: current_user, lab: @lab)
    authorize_action_for @lab
    if @lab.save
      UserMailer.delay.lab_submitted(@lab.id)
      AdminMailer.delay.lab_submitted(@lab.id)
      redirect_to labs_path, notice: "Thanks for adding your lab. We shall review your application and be in touch."
    else
      # @lab.employees.build if @lab.employees.empty?
      @lab.links.build
      render :new
    end
  end

  def show
    begin
      @lab = Lab.with_approved_state.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return redirect_to root_path, notice: "Lab not found"
    end
    # @people = [@lab.creator]
    @employees = @lab.employees.includes(:user).active.order('employees.id ASC')
    @machines = @lab.machines
    @events = @lab.events
    @nearby_labs = @lab.nearby_labs(false, 1000)
    @nearby_labs = @nearby_labs.limit(5) if @nearby_labs
    authorize_action_for @lab
  end

  def destroy
    @lab = Lab.friendly.find(params[:id])
    authorize_action_for @lab
    @lab.delete
    redirect_to labs_path, notice: "Lab deleted"
  end

  def edit
    @lab = Lab.friendly.find(params[:id])
    @lab.links.build
    authorize_action_for @lab
  end

  def update
    @lab = Lab.friendly.find(params[:id])
    authorize_action_for @lab
    if @lab.update_attributes lab_params
      track_activity @lab
      redirect_to lab_url(@lab), notice: "Lab was successfully updated"
    else
      @lab.links.build
      render :edit
    end
  end

  def manage_admins
    @lab = Lab.friendly.find(params[:id])
    authorize_action_for @lab
    @admins = @lab.admins
    @users = User.all# - User.with_role(:admin) - [current_user]
  end

private

  def lab_params
    params.require(:lab).permit(
      :kind,
      :parent_id,
      :referee_id,
      :machines_list,
      :geocomplete,
      :name,
      :blurb,
      :description,
      :slug,
      :avatar_src,
      :header_image_src,
      :address_1,
      :address_2,
      :city,
      :county,
      :postal_code,
      :country_code,
      :latitude,
      :longitude,
      :zoom,
      :address_notes,
      :phone,
      :email,
      :application_notes,
      :tools_list,
      capabilities: [ ],
      links_attributes: [ :id, :link_id, :url, '_destroy' ],
      employees_attributes: [ :id, :job_title, :description ]
    )
  end

end
