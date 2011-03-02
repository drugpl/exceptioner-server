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
    @project = current_user.projects.find(params[:id])
  end

  def create
    @project = current_user.projects.new(params[:project])
    if @project.save
      redirect_to projects_path(current_user)
    else
      render :new
    end
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def update
    @project = current_user.projects.find(params[:id])

    if @project.update_attributes(params[:project])
      redirect_to projects_path(current_user)
    else
      render :action => "edit"
    end
  end

  def destroy
    project = current_user.projects.find(params[:id])
    project.destroy
    unless Project.exists?(project)
      redirect_to projects_path(current_user), :notice => t('projects.actions.destroy.successful')
    else
      redirect_to projects_path(current_user), :alert => t('projects.actions.destroy.failed')
    end
  end
end
