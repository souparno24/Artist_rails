class CommentsController < ApplicationController
   
   

    def create
        @comment=Comment.new(comment_params)
        @comment.user_id=current_user.id if logged_in?
        if @comment.save
            flash[:success] = "Review done!"
            redirect_to dashboard_path
        else
            redirect_to dashboard_path,flash:{danger:"unable to save"}
        end

    end

    
    private

    def comment_params
        params.require(:comment).permit(:comment,:post_id)
    end
end