class SchoolClassesController < ApplicationController
  before_action :authenticate_user!

  def index
    @school_classes = policy_scope(SchoolClass)
  end

  def show
    @school_class = SchoolClass.find(params[:id])
    authorize @school_class
  end

  def new
    @school_class = SchoolClass.new
    authorize @school_class
  end

  def create
    @user = User.find(current_user.id)
    @school_class = SchoolClass.new(new_school_class_params)
    @school_class.user = @user
    authorize @school_class

    if @school_class.save
      redirect_to school_class_path(@school_class)
    else
      render :new
    end
  end

  def edit
    # after @school_class is defined:
    authorize @school_class
  end

  def update
    # after @school_class is defined:
    authorize @school_class
  end

  def destroy
    # after @school_class is defined:
    authorize @school_class
  end

  private

  def new_school_class_params
    params.require(:school_class).permit( :name, :description )
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to access this class."
    redirect_to(root_path)
  end
end
