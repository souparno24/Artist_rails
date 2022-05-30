class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_account,only: [:show]
  before_action :not_logged_in_user,only: [:new,:create]

 

  def show
    @user=User.find_by_name(params[:name])
    @posts=@user.posts

  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if User.first
      @user.update(admin:false)
    
    end
    if @user.save
      
      log_in @user
      flash[:success] = "Welcome to artist directory!!!!"
      redirect_to profile_path(@user.name)
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
    def not_logged_in_user
      unless !logged_in?
    
        flash[:danger] = "Already Logged in."
        redirect_to dashboard_path
      end
    end

     # Confirms the correct user.
     def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end