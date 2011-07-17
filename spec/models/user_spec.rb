# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime

require 'spec_helper'

describe User do

  before(:each) do
    @attr = { :name => 'Example User', :email => 'user@example.com' }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

#--------name validations
  it "should require a name" do
    @attr[:name] = ""
    no_name_user = User.new(@attr)
    no_name_user.should_not be_valid
  end

  it "should reject names that are too long" do
    @attr[:name] = 'x' * 51
    long_name_user = User.new(@attr)
    long_name_user.should_not be_valid
  end


#-------email validations
  it "should require an email" do
    @attr[:email] = ''
    no_email_user = User.new(@attr)
    no_email_user.should_not be_valid
  end

  it "should accept emails with valid syntax" do
    valid_emails = %w[
          user@foo.com 
          THE_USER@foo.bar.org
          first.last@foo.jp
    ]

    valid_emails.each do |email|
      @attr[:email] = email
      valid_email_user = User.new(@attr)
      
      valid_email_user.should be_valid
    end

  end

  it "should reject emails with invalid syntax" do
    invalid_emails = %w[
      user@foo,com
      user_at_foo.org
      example.user@foo.
    ]

    invalid_emails.each do |email|
      @attr[:email] = email
      invalid_email_user = User.new(@attr)

      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate emails" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)

    user_with_duplicate_email.should_not be_valid
  end

  it "should reject emails that differ only by case" do

    User.create(@attr) 
    @attr[:email] = @attr[:email].upcase
    user_with_different_case_email = User.new(@attr)

    user_with_different_case_email.should_not be_valid
  end




end



