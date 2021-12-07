class Api::V1::SchoolClassesController< Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  def index
    @school_classes = policy_scope(SchoolClass)
  end

  def show
    @school_class = SchoolClass.find(params[:id])
    authorize @school_class
  end

  def update
    @school_class = SchoolClass.find(params[:id])
    authorize @school_class
    if @school_class.update(school_class_params)
      render :show
    else
      render_error
    end
  end

  def create
    @school_class = SchoolClass.new(school_class_params)
    @school_class.user = current_user
    authorize @school_class
    if @school_class.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @school_class = SchoolClass.find(params[:id])
    authorize @school_class
    @school_class.destroy
    head :no_content
  end

  private

  def school_class_params
    params.require(:school_class).permit( :name, :description )
  end

  def render_error
    render json: { errors: @school_class.errors.full_messages },
      status: :unprocessable_entity
  end
end
