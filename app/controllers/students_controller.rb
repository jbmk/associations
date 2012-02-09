class StudentsController < ApplicationController
  before_filter :check, :except => [:index, :show, :new, :create]
  
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(params[:student])
    @student.user_id = current_user.id
    if @student.save
      redirect_to @student, :notice => "Successfully created student."
    else
      render :action => 'new'
    end
  end

  

  def edit
    @student = Student.find(params[:id])
  end

  def assign_course
    @student = Student.find(params[:id])
    @student.course_ids.each do |arr|
      @course_student = CourseStudent.new
      @course_student.student_id = @student.id
      @course_student.course_id = arr
    end
  end
  
  def raise_error_for_empty
    if params[:student].blank?
      @student.courses = []
      @student.update_attributes(params[:student])
      redirect_to assign_course_student_path, :alert => "Atleast One Course Should be Assigned to a Student"
    else
      @student.update_attributes(params[:student])
      redirect_to @student
    end
  end

  def update
    @student = Student.find(params[:id])
    @student.user_id = current_user.id
    if @student.update_attributes(params[:student])
      redirect_to @student, :notice  => "Successfully updated student."
    else
      render :action => 'edit'
    end
  end

  

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to students_url, :notice => "Successfully destroyed student."
  end

  private
  def check
    @student = Student.find(params[:id])
    if @student.user_id != current_user.id
      redirect_to students_path, :notice => "This Action Can't be Done by You"
    end
  end
end