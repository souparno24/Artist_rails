
  
class PostsController < ApplicationController
    before_action :admin_user, only: [:new,:create,:edit,:update]
   
  
    def new
        @post=Post.new
    end

    def create
        @post=Post.new(post_params)
        @post.user_id=current_user.id if logged_in?
        if @post.save
            flash[:success] = "artist created!"
            redirect_to dashboard_path
            
        else
            flash[:danger] = "artist not created!"
        end

    end

    def show
       
        @post =Post.find(params[:id])
        @stars=@post.stars
       
    end

    def edit
        @post = Post.find(params[:id])
      end
    
      def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            flash[:success] = "Artist updated"
            redirect_to dashboard_path
        else
          render 'edit'
        end
      end

      def destroy
        Post.find(params[:id]).destroy
        flash[:success] = "Artist deleted"
        redirect_to dashboard_path
      end

    private

    def post_params
        params.require(:post).permit(:name,:email,:dob,:category,:location,:url)
    end
    def admin_user
        
        redirect_to(dashboard_path) unless current_user.admin?
       
      end
  
end