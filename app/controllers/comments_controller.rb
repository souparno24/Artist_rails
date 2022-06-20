class CommentsController < ApplicationController
    before_action :logged_in_user,only: [:create,:accept,:reject]
    before_action :admin_user, only: [:create,:accept,:reject]
   

    def create
        @comment=Comment.new(comment_params)
        @comment.user_id=current_user.id if logged_in?
        if @comment.save
            flash[:success] = "Review added,waiting for admin approval!"
            redirect_to dashboard_path
        else
            redirect_to dashboard_path,flash:{danger:"unable to save"}
        end

    end
    def accept
        @comment=Comment.find(params[:id])
        @comment.update(active:true)
       
        redirect_to dashboard_path, flash:{success:"Review accepted"}
    end
    def reject
     
            Comment.find(params[:id]).destroy
            flash[:danger] = "Review deleted"
            redirect_to dashboard_path
          
    end


    
    private

    def comment_params
        params.require(:comment).permit(:comment,:post_id)
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