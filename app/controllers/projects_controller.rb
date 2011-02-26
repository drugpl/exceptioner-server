class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @projects = current_user.projects
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
      redirect_to projects_path
    else
      render :new
    end
  end
end
