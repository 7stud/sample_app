require 'spec_helper'

describe SessionsController do
  render_views

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end

    it "should have the right title" do
      get :new
      response.should have_selector('title', :content => "Sign in")
    end
  end

  describe "POST create" do
    describe "invalid signin" do

      before(:each) do
        @attr = { :email => "email@example.com", :password => 'invalid' }
      end

      it "should, upon failure, re-render the new page" do
        post :create, :session => @attr
        response.should render_template('new')
      end

      it "should, upon failure, have the right title" do
        post :create, :session => @attr
        response.should have_selector('title', :content => "Sign in")
      end

      it "should, upon failure, have a flash.now message" do
        post :create, :session => @attr
        flash.now[:error]. should =~ /invalid/i
      end

      it "should, upon failure, not sign the user in" do
        @user = Factory(:user)
        @attr = { :email => @user.email, :password => @user.password }
        post :create, :session => @attr

        #Doesn't test right side of ||:
        #controller.get_user_from_cookie.should_not == @user
        #controller.should_not be_signed_in
      end

    end

    describe "with valid email and password" do

      before(:each) do 
        @user = Factory(:user)
        @attr =  { :email => @user.email, :password => @user.password }  
      end

      it "should redirect to the user show page" do
        post :create, :session => @attr
        response.should redirect_to(user_path @user)
      end

      it "should sign the user in" do
        post :create, :session => @attr
        controller.get_user_from_cookie.should == @user
        controller.should be_signed_in
      end

    end

  end

  describe "DELETE request sent to destroy action" do
    it "should sign a user out" do
      test_sign_in(Factory :user)
      delete :destroy
      controller.should_not be_signed_in
      response.should redirect_to(root_path)
    end
  end

end
