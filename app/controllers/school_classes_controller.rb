class SchoolClassesController < ApplicationController
  before_action :authenticate_user!

  def index
    @school_classes = SchoolClass.all
  end

  def show
    @school_class = SchoolClass.find(params[:id])
  end

  def new
    
  end

  def create
    
  end

  def edit
    
  end

  def update

  end

  def destroy

  end
end
