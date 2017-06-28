class Api::V1::StudentsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  def index
    @school_class = policy_scope(SchoolClass).find(params[:school_class_id])
    @students = @school_class.students.order(first_name: :asc)
  end
end
