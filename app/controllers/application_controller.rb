require "application_responder"
require "active_support"

class ApplicationController < ActionController::API
  self.responder = ApplicationResponder
  respond_to :html

end
