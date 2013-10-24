class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!

  rescue_from Exception, with: :generic_error

  def raise_not_found!
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end

  protected

  def generic_error exception
    render_error 500, exception
  end

  def render_error(status, exception)
    @status=status
    @exception=exception
    render template: "errors/details",locals: { status: status, exception: exception}
  end
end
