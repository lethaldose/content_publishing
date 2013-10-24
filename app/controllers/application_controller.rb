class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!


  def render_error(status, exception)
    @status=status
    @exception=exception
    render template: "errors/#{status}", status: status
  end
end
