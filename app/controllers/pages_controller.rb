class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if session
      if session[:current_class]
        redirect_to school_class_path(session[:current_class])
      else
        redirect_to school_classes_path
      end
    else
      redirect_to '/'
    end
  end
end
