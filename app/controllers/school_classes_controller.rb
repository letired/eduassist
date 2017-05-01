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
    @school_class = SchoolClass.new(new_class_params)
    @school_class.user = User.find(params[:user_id])
    @school_class.save
    redirect_to "school_classes/index"
  end

  def edit
    @school_class = SchoolClass.find(params[:id])
  end

  def update

  end

  def destroy

  end

  private

  def new_class_params
    params.require(:school_class).permit(:name, :description)
  end
end
