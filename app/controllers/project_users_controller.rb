class ProjectUsersController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @project_user = ProjectUser.new
    @project_user.project_id = params[:project_id]
  end
  def create
    @project_user = ProjectUser.new
    @project_user.project_id = params[:project_id]
    user = User.find_by_email(params[:project_user][:email])
    @project_user.user_id = user.id if user
    if @project_user.save
      redirect_to project_path(params[:project_id])
    else
      render :new, flash[:errors] << t('project_users.actions.add_user.failed')

    end
  end
  def destroy
  end
end
