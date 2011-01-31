class ApiController < ApplicationController
  API_VERSION = "0.1"

  before_filter :require_valid_token
  before_filter :require_valid_version

  protected
  def require_valid_token
    @api_token = request.headers["API-Key"]
    render_403(:api_key => 'invalid api key') unless @api_token && verify_token(@api_token)
  end

  def require_valid_version
    render_404(:api_version => 'unknown api version') unless params[:version] == API_VERSION
  end

  def verify_token(token)
    Project.find_by_api_token(token)
  end

  def render_403(message)
    render :status => 403, :json => message
  end

  def render_404(message)
    render :status => 404, :json => message
  end
end
