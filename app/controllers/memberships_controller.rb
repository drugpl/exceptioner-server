class MembershipsController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @project_user = Membership.new
    @project_user.project_id = params[:project_id]
  end
  def create
    @project_user = Membership.new
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
    @project_user = Membership.where(:project_id => current_user.projects).find(params[:project_id])
    @project = @project_user.project
    @project_user.destroy
    flash[:notice] = t('project_users.actions.remove_user.successful')
    redirect_to @project
  end
end
