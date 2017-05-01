class SchoolClassesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @school_class = SchoolClass.new
  end

  def create
    @user = User.find(current_user.id)
    @school_class = SchoolClass.new(new_school_class_params)
    @school_class.user = @user
    if @school_class.save
      redirect_to school_class_path(@school_class)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def new_school_class_params
    params.require(:school_class).permit( :name, :description )
  end
end
