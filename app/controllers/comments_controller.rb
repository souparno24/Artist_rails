class CommentsController < ApplicationController
   
   

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
end