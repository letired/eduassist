class GradesController < ApplicationController
  def update
    @grade = Grade.find(params[:grade][:id])
    authorize @grade
    @student = @grade.student
    authorize @student
    if @grade.update(grade_params)
      redirect_to assignments_student_path(@student), notice: "Student's grade was updated successfully."
    else
      render :edit
    end
  end

  def stats
    @school_class = policy_scope(SchoolClass).find(params[:id])

    @assignments = Assignment.where(school_class_id: @school_class).order(date: :asc)

    @categories = []
    @answer = {}

    @assignments.each do |ass|
       @categories <<  ass.category
    end

    @categories = @categories.uniq!

    @categories.each do |cat|
      points = 0
      amount = 0
      maxPoints = 0
      amount2 = 0
      ass2 = @assignments.where(category: cat)
      ass2.each do |as2|
        as2.grades.each do |gra|
          points += gra.earned_points
          amount += 1
        end
      end
      ass3 = @assignments.where(category: cat)
      ass3.each do |as3|
        maxPoints += as3.max_points
        amount2 += 1
      end
      allPoints = (maxPoints/amount2).to_f
      av = ((points / amount) / allPoints * 100).floor
      @answer[cat] = av
    end

    @grades = Grade.where(school_class_id: @school_class).order(date: :asc)
    rescue ActiveRecord::RecordNotFound
      user_not_authorized_to_access_class
  end

  private

  def grade_params
    params.require( :grade ).permit( :earned_points )
  end

  def user_not_authorized_to_access_class
    flash[:alert] = "You are not authorized to access this class."
    redirect_to(root_path)
  end
end

