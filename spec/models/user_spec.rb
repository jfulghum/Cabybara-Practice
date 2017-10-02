require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) { FactoryGirl.create(:user) }

  # validations
  it { should validate_presence_of(:session_token) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:username) }

  it { should validate_length_of(:password).is_at_least(6) }

  it { should validate_uniqueness_of(:username) }

  # associations
  it { should have_many(:goals) }

  # class methods
  describe '::find_by_credentials' do

    it 'should return a user if the username and password are valid' do
      expect(User.find_by_credentials('sicko', 'password')).to eq(user)
    end

    it 'should return nil otherwise' do
      expect(User.find_by_credentials('notthatsick', '___5__')).to be nil
    end
  end

  # instance methods
  describe '#reset_session_token!' do
    it 'should change the session_token for a user' do
      old_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(old_token)
    end

    it 'should return that same gobbledy-guck' do
      new_token = user.reset_session_token!
      expect(user.session_token).to eq(new_token)
    end

  end

  describe '#is_password?' do
    it 'should return true if we pass in the correct password' do
      expect(user.is_password?('password')).to be true
    end

    it 'should return false if we do not pass in the correct password' do
      expect(user.is_password?('totally_not_the_password')).to be false
    end
  end

  describe '#password=' do
    it 'should set the password_digest to an encrypted version of the password' do
      my_password = 'awesome'
      user.password = my_password
      expect(BCrypt::Password.new(
        user.password_digest).is_password?(my_password)
      ).to be true
    end
  end

  describe "ensure_session_token" do
    it 'should give a user without a session token a session token' do
      user.session_token = nil
      user.ensure_session_token
      expect(user.session_token).to_not be nil
    end

  end


end
