class StarsController < ApplicationController
   
   

    def create
        @star=Star.new(star_params)
        @star.user_id=current_user.id if logged_in?
        if @star.save
            flash[:success] = "Rating added!"
            redirect_to dashboard_path
        else
            redirect_to dashboard_path,flash:{danger:"unable to save"}
        end

    end

    
    private

    def star_params
        params.require(:star).permit(:star,:post_id)
    end
end