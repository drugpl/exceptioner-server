class Api::IssuesController < ApiController
  respond_to :json

  def create
    @issue = Issue.new(params[:issue])
    @issue.project = Project.find_by_api_token(@api_token)
    @issue.save
    respond_with(@issue, :location => root_url)
  end
end
