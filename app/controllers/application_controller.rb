class ApplicationController < ActionController::Base
  protect_from_forgery

  unless Rails.env == 'development'
    rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  end

  def render_404(exception)
    render :file => File.join(Rails.public_path, '404.html'), :status => 404
  end

end
