class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :index]
  before_filter :correct_user, :only => [:edit, :update]

  def index
    #@users = User.all
    @users = User.paginate(:page => params[:page]) #User.all
    @title = "All users"

  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
 
  def new  # '/signup' routes here
    @user = User.new
    @title = "Sign up"
    #The sign up page's submit button POST's to '/users'
  end
 
  def create  # POST requests to '/users' routes here
    @user = User.new(params[:user])

    if @user.save
      sign_in @user
      flash[:success] = "Welcome to Grant's website." 
      redirect_to @user #goes to user 'show' page

    else
      @title = 'Sign up'

      #If password errors, then erase passwords.
      #If no password errors, redisplay passwords.
      if @user.errors.full_messages.any? {|error| error.match /password/i}
          @user.password = ''
          @user.password_confirmation = ''
      end
      render 'new'
    end
  end

  def edit 

    #Now @user is retrieved by correct_user() in
    #sessions_helper.rb:
    #@user = User.find(params[:id])

    @title = "Edit user"
    #before filter redirects to signin_path
  end

  def update
    #Now @user is retrieved by correct_user() in
    #sessions_helper.rb:
    #@user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      #success
      flash[:success] = "Your information was updated"
      redirect_to @user
    else
      #failure
      @title = "Edit user"
      render 'edit' #needs @user variable
    end
  end

  

  private

    def authenticate
      deny_access unless signed_in?  
      #deny_access is in sessions_helper.rb
    end


    def correct_user
      @user = User.find(params[:id])
      #@session_id = get_user_from_session.id
      #@session_id_class = get_user_from_session.id.class
      #@params_id = params[:id]
      #@params_id_class = params[:id].class


      #redirect_to(root_path) unless get_user_from_session == @user
      #redirect_to(root_path) unless get_user_from_session.id.to_s == params[:id]
      redirect_to(root_path) unless current_user?(@user)
    end

    

end
