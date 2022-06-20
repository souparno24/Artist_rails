class StarsController < ApplicationController
    before_action :logged_in_user,only: [:create,:accept,:reject]
    before_action :admin_user, only: [:create,:accept,:reject]
   

    def create
        @star=Star.new(star_params)
        @star.user_id=current_user.id if logged_in?
        if @star.save
            flash[:success] = "Rating added,waiting for admin approval!"
            redirect_to dashboard_path
        else
            redirect_to dashboard_path,flash:{danger:"unable to save"}
        end

    end
    def accept
        @star=Star.find(params[:id])
        @star.update(active:true)
       
        redirect_to dashboard_path, flash:{success:"Rating accepted"}
    end
    def reject
     
        Star.find(params[:id]).destroy
            flash[:danger] = "Rating deleted"
            redirect_to dashboard_path
          
    end

    
    private

    def star_params
        params.require(:star).permit(:star,:post_id)
    end


    def logged_in_user
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end
      def admin_user
        if !current_user.admin?
        flash[:danger] = "Not authorized"
        end
          redirect_to(dashboard_path) unless current_user.admin?
         
        end
end