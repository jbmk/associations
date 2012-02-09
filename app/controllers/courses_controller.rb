class CoursesController < ApplicationController
  before_filter :check, :except => [:index, :show, :new, :create]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(params[:course])
    @course.user_id = current_user.id
    if @course.save
      redirect_to @course, :notice => "Successfully created course."
    else
      render :action => 'new'
    end
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
     @course = Course.find(params[:id])
     @course.user_id = current_user.id
    if @course.update_attributes(params[:course])
      redirect_to @course, :notice  => "Successfully updated course."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    redirect_to courses_url, :notice => "Successfully destroyed course."
  end

  private
  def check
    @course = Course.find(params[:id])
    if @course.user_id != current_user.id
      redirect_to courses_path, :notice => "This Action Can't be Done by You"
    end
  end
  
end
