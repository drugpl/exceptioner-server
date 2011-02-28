class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @projects = current_user.projects.paginate :page => params[:page],
                                               :order => 'updated_at DESC',
                                               :per_page => 10
  end

  def new
    @project = current_user.projects.new
  end

  def show
    @project = Project.find(params[:id])
    @issues = @project.issues
  end

  def create
    if current_user.projects.create!(params[:project])
      redirect_to projects_path(current_user)
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    project = Project.find(params[:id])

    if project.update_attributes(params[:project])
      redirect_to projects_path(current_user)
    else
      render :action => "edit"
    end
  end

  def destroy
    project = Project.find(params[:id])
    if project
      project.destroy
    else
      redirect_to projects_path(current_user), :notice => 'No such project'
    end

    redirect_to projects_path(current_user)
  end
end
