class Api::V1::AssignmentsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User
  def index
    @school_class = policy_scope(SchoolClass).find(params[:school_class_id])
    @assignments = @school_class.assignments
  end
end
