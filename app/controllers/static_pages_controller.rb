class StaticPagesController < ApplicationController
  before_action :logged_in_user, only: [:home]
 

  def home
  end

  private
     # Confirms a logged-in user.
     def logged_in_user
      unless !logged_in?
        store_location
        
        redirect_to dashboard_path
      end
    end
end
