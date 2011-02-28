class IssuesController < ApplicationController
  def show
    @project = Project.find(params[:project_id])
    @issue = Issue.find(params[:id])
  end
end
