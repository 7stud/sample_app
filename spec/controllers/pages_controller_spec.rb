require 'spec_helper'

describe PagesController do
  render_views

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have the right title" do
      get 'home'
      response.should have_selector("title", :content => "Grant's website | Home")
    end

  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end

    it "should have the right title" do
      get 'contact'
      response.should have_selector("title", :content => "Grant's website | Contact")
    end

  end

  describe "GET 'about'" do
    it "should test" do
      get 'about'
      response.should be_success
    end

    it "should have the right title" do
      get 'about'
      response.should have_selector("title", :content => "Grant's website | About")
    end
  end

  describe "GET help" do
    it "should be succesful" do
      get 'help'
      response.should be_success
    end

    it "should have correct title" do
      get 'help'
      response.should have_selector("title", :content => "Grant's website | Help")
    end
  end


end
