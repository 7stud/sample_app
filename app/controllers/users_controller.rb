class UsersController < ApplicationController
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
      flash[:success] = "Welcome to Grant's website." 
      redirect_to @user #goes to user 'show' page
    else
      @title = 'Sign up'
      render 'new'
    end
  end

    
  

end
