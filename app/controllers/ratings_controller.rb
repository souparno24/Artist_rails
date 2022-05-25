class RatingsController < ApplicationController
   
   

    def create
        @rating=Rating.new(rating_params)
        @rating.user_id=current_user.id if logged_in?
        if @rating.save
            flash[:success] = "Rating added!"
            redirect_to dashboard_path
        else
            redirect_to dashboard_path,flash:{danger:"unable to save"}
        end

    end

    
    private

    def rating_params
        params.require(:rating).permit(:rating,:post_id)
    end
end