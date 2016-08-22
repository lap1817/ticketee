class Admin::ApplicationController < ApplicationController
  before_action :authorize_user!
  
  def index
  end
  
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  
  private 
	def authorize_user!
		authenticate_user!
		
		unless current_user.admin?
			redirect_to root_path, alert: "You must be an admin to do that."
		end
	end
	
	def not_authorized
		redirect_to root_path, alert: "You aren't allowed to do that."
	end

end
