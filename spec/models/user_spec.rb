require 'rails_helper'

RSpec.describe User, type: :model do
  user_no_password = User.new(first_name: 'Some', last_name: 'Guy', email:'someguy@email.com', password_confirmation: 'secret')

  user_no_password_confirmation = User.new(first_name: 'Some', last_name: 'Guy', email:'someguy@email.com', password: 'secret')

  user_passwords_dont_match = User.new(first_name: 'Some', last_name: 'Guy', email:'someguy@email.com', password: 'secrey', password_confirmation: 'secret')

  user_email_case1 = User.new(first_name: 'Some', last_name: 'Guy', email:'someguy@email.com', password: 'secret', password_confirmation: 'secret')
  user_email_case2 = User.new(first_name: 'Some', last_name: 'Guy', email:'SOMEGUY@email.com', password: 'secret', password_confirmation: 'secret')

  user_no_first_name = User.new(last_name: 'Guy', email:'someguy@email.com', password: 'secret', password_confirmation: 'secret')

  user_no_last_name = User.new(first_name: 'Some', email:'someguy@email.com', password:'secret', password_confirmation:'secret')

  user_no_email = User.new(first_name: 'Some', last_name: 'Guy', password:'secret', password_confirmation:'secret')

  it 'should reject a user lacking a password' do
    user_no_password.save
    expect(user_no_password).to_not(be_persisted)
  end

  it 'should reject a user lacking a password confirmation' do
    user_no_password_confirmation.save
    expect(user_no_password_confirmation).to_not be_persisted
  end

  it 'should reject if password and password confirmation dont match' do
    user_passwords_dont_match.save
    expect(user_passwords_dont_match).to_not be_persisted
  end

  it 'should not allow matching emails in the database' do
    user_email_case1.save
    user_email_case2.save
    expect(user_email_case2).to_not be_persisted
  end

  it 'should reject a user lacking a first name' do
    user_no_first_name.save
    expect(user_no_first_name).to_not be_persisted
  end

  it 'should reject a user lacking a last name' do
    user_no_last_name.save
    expect(user_no_last_name).to_not be_persisted
  end

  it 'should reject a user lacking an email address' do
    user_no_email.save
    expect(user_no_email).to_not be_persisted
  end


  describe '.authenticate_with_credentials' do
    let(:a_valid_user) { User.new(first_name: 'Some', last_name: 'Guy', email:'someguy3@email.com', password: 'secret', password_confirmation: 'secret') }

    it 'should allow a valid user to be saved to the db' do
      a_valid_user.save
      expect( a_valid_user ).to be_persisted
    end

    it 'should return nil when tested with no email' do
      expect(User.authenticate_with_credentials('', 'secret')).to be nil
    end

    it 'should return nil when tested with no password' do
      expect(User.authenticate_with_credentials('someguy3@email.com', '')).to be nil
    end

    it 'should return user (logged in) when tested with case in email' do
      a_valid_user.save
      expect(User.authenticate_with_credentials('Someguy3@email.com', 'secret')).to_not be nil
    end

    it 'should return user (logged in) when tested with white space in email' do
      a_valid_user.save
      expect(User.authenticate_with_credentials('  someguy3@email.com  ', 'secret')).to_not be nil
    end

  end
end















