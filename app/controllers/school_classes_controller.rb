class SchoolClassesController < ApplicationController
  before_action :authenticate_user!

  def index
    @school_classes = SchoolClass.all
  end

  def show
    @school_class = SchoolClass.find(params[:id])
  end

  def new
    @school_class = SchoolClass.new
  end

  def create
    @user = User.find(current_user.id)
    @school_class = SchoolClass.new(school_class_params)
    @school_class.user = @user
    if @school_class.save
      redirect_to new_school_class_student_path(@school_class), notice: "School Class was created successfully. Let's add the first student."
    else
      render :new
    end
  end

  def edit
    @school_class = SchoolClass.find(params[:id])
  end

  def update
    @school_class = SchoolClass.find(params[:id])
    @user = User.find(current_user.id)
    if @school_class.update(school_class_params)
      redirect_to school_class_path(@school_class), notice: 'School Class was updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    school_class = SchoolClass.find(params[:id])
    school_class.destroy
    redirect_to school_classes_path, notice: 'School Class was deleted successfully.'
  end

  private

  def school_class_params
    params.require(:school_class).permit( :name, :description )
  end
end
