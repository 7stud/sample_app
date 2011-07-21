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
    @attr = { 
      :name => 'Example User', 
      :email => 'user@example.com',
      :password => 'foobar',
      :password_confirmation => 'foobar',
    }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

#--------name validations:
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


#-------email validations:
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

    User.create!(@attr) 
    @attr[:email] = @attr[:email].upcase
    user_with_different_case_email = User.new(@attr)

    user_with_different_case_email.should_not be_valid
  end



#-------password validations:
  describe "password validations" do

    it "should require a password" do
      @attr[:password] = ''
      @attr[:password_confirmation] = ''
      
      no_password_user = User.new(@attr)
      
      no_password_user.should_not be_valid
    end

    it "should match confirmation" do
      @attr[:password_confirmation] = 'barfoo'
      no_confirmation_match_user = User.new(@attr)
      no_confirmation_match_user.should_not be_valid
    end

    it "should not be too short" do
      @attr[:password] = 'hi'
      @attr[:password_confirmation] = 'hi'

      too_short_password_user = User.new(@attr)
      too_short_password_user.should_not be_valid
    end

    it "should not be too long" do
      @attr[:password] = 'x' * 41
      too_long_password_user = User.new(@attr)
      too_long_password_user.should_not be_valid
    end

  end


#-----password encryption:

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end

    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end

      it "should be false if the passwords don't match" do
        @user.has_password?('invalid').should be_false
      end
    end
  
    describe "authenticate method" do
      it "should return nil if password/email mismatch" do
        wrong_password_user = User.authenticate(@user[:email], 'wrong_pass')
        wrong_password_user.should be_nil 
      end

      it "should return nil if email doesn't exist" do
        nonexistent_user = User.authenticate('foo@bar.com', @user[:password])
        nonexistent_user.should be_nil
      end

      it "should return the user if password/email match" do
        authorized_user = User.authenticate(@attr[:email], @attr[:password])
        authorized_user.should == @user
      end

    end

  end
end

  

