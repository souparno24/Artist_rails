
  
class PostsController < ApplicationController
  before_action :logged_in_user,only: [:new,:create,:edit,:show,:update,:destroy]
    before_action :admin_user, only: [:new,:create,:edit,:update,:destroy]
   
      
  def index

    @q = Post.ransack(params[:q])
    @category=
    @posts = @q.result
    @comment=Comment.new
    @star=Star.new
  
  end
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
          
          render 'new'
         
        end

    end

    def show
       
        @post =Post.find(params[:id])
        @stars=@post.stars
        @image=Image.new
        @category=Category.new
      
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
       
        flash[:danger] = "Artist deleted"
        redirect_to dashboard_path
      end

    

    private

    def post_params
        params.require(:post).permit(:name,:email,:dob,:description,:location,:url)
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