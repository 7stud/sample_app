require 'spec_helper'

describe User do
  #pending "add some examples to (or delete) #{__FILE__}"

  before(:each) do
    @attr = { :name => 'Example User', :email => 'user@example.com' }
  end

  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end

  it "should require a name"
end

# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

