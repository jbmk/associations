class StudentsController < ApplicationController
  before_filter :check, :except => [:index, :show, :new, :create,
    :excel_import, :excel_upload]

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
  end
  
  
  def raise_error_when_no_courses_assigned
    @student.update_attributes(params[:student])
    if params[:student].blank?
      @student.courses = []
      redirect_to assign_course_student_path, :alert => "Atleast One Course Should be Assigned to #{@student.name}"
    else
      redirect_to @student
    end
  end

  def excel_upload
  end

 
  def excel_import
    require 'spreadsheet'
    book = Spreadsheet.open(params[:dump][:file].original_filename)
    sheet1 = book.worksheet 0
    n = 0
    sheet1.each do |row|
      @student = Student.new
      @student.user_id = current_user.id
      @student.name = row[0]
      @student.age = row[1]
      @student.address = row[2]
      if @student.save
        n += 1
      end
    end
    redirect_to students_url, :notice => "Excel Import Successful, #{n} New records added to data base"
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

  
