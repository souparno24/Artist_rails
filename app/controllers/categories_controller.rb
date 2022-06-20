class CategoriesController < ApplicationController
  before_action :logged_in_user,only: [:create,:edit,:update,:destroy]
    before_action :admin_user, only: [:create,:edit,:update,:destroy]
   

    def create
        @category=Category.new(category_params)
        @category.user_id=current_user.id if logged_in?
        if @category.save
            flash[:success] = "Category added!"
            redirect_to post_path(category_params[:post_id])
        else
            redirect_to dashboard_path,flash:{danger:"unable to save"}
        end

    end


    def edit
        @category =Category.find(params[:id])
      end
    
      def update
        @category= Category.find(params[:id])
        if @category.update(category_params)
            flash[:success] = "Artist category updated"
            redirect_to dashboard_path
        else
          render 'edit'
        end
      end
    

      def destroy
        Category.find(params[:id]).destroy
        flash[:danger] = "Category Deleted"
        redirect_to dashboard_path
      end

    private

    def category_params
        params.require(:category).permit(:category,:post_id)
    end

    def admin_user
        if !current_user.admin?
        flash[:danger] = "Not authorized"
        end
          redirect_to(dashboard_path) unless current_user.admin?
         
        end


    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
end