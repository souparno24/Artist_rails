class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_account,only: [:show]

  def index
   
    @posts=Post.all.order(:name)
    @comment=Comment.new
    @star=Star.new
    
    if params[:search]
      @search_term=params[:search]
      @posts=@posts.search_by(@search_term)
    end
    
end

  def show
    @user=User.find_by_name(params[:name])
    @posts=@user.posts

  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def set_account
    @user=User.find_by_name(params[:name])
end



  private


    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
     # Confirms an admin user.
     def admin_user
      redirect_to(root_url) unless current_user.admin?
    end


    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

     # Confirms the correct user.
     def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end