class ImagesController < ApplicationController
   
    before_action :admin_user,only: [:create,:purge_image]

    def create
        @image=Image.new(image_params)
        @image.user_id=current_user.id if logged_in?
        if @image.save
            flash[:success] = "Images added!"
            redirect_to post_path(image_params[:post_id])
        else
            redirect_to post_path(image_params[:post_id]),flash:{danger:"unable to save"}
        end

    end

    def purge_image
        @image=Image.find(params[:id])
        @image.image.purge
       
        redirect_to dashboard_path, flash:{danger:"Photo Deleted"}
    end

    
    private

    def image_params
        params.require(:image).permit(:image,:post_id)
    end

    def admin_user
        redirect_to(root_url) unless current_user.admin?
      end
end