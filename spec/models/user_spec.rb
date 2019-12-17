require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    subject {
      described_class.new(
      first_name:  'John',
      last_name: 'Doe',
      email: 'example@gmail.com',
      password: 'sfdka;kf;12321',
      password_confirmation: 'sfdka;kf;12321'
      )
    }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid with blank first name" do
      subject.first_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with blank last name" do
      subject.last_name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with blank email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with an already registered email (regardlesss of case)" do
      user = User.create(
        first_name:  'Jon',
        last_name: 'Test',
        email: 'same@gmail.com',
        password: 'sfdka;kf;12321',
        password_confirmation: 'sfdka;kf;12321'
          )
      user_two = User.create(
        first_name:  'Validation',
        last_name: 'Test',
        email: 'sAme@gMail.com',
        password: 'sfdka;kf;12321',
        password_confirmation: 'sfdka;kf;12321'
          )
      expect(user_two).to_not be_valid
    end

    it "is not valid when password and password_confirmation do not match" do
      subject.password_confirmation = "different"
      expect(subject).to_not be_valid
    end

    it "is not valid with blank password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with blank password_confirmation" do
      subject.password_confirmation = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with a password length of less than 5" do
      subject.password = "1234"
      subject.password_confirmation = "1234"
      expect(subject).to_not be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    it "should authenticate when given proper credentials" do
      user = User.create(
        first_name:  'Validation',
        last_name: 'Test',
        email: 'example@gmail.com',
        password: 'sfdka;kf;12321',
        password_confirmation: 'sfdka;kf;12321'
          )
        user_session = described_class.authenticate_with_credentials('example@gmail.com', "sfdka;kf;12321")
        expect(user_session).to_not be_nil
    end
    it "should not authenticate when given wrong password" do
      user = User.create(
        first_name:  'Validation',
        last_name: 'Test',
        email: 'example@gmail.com',
        password: 'sfdka;kf;12321',
        password_confirmation: 'sfdka;kf;12321'
          )
        user_session = described_class.authenticate_with_credentials('example@gmail.com', "wrongpassword")
        expect(user_session).to be_nil
    end
    it "should not authenticate when given wrong email" do
      user = User.create(
        first_name:  'Validation',
        last_name: 'Test',
        email: 'example@gmail.com',
        password: 'sfdka;kf;12321',
        password_confirmation: 'sfdka;kf;12321'
          )
        user_session = described_class.authenticate_with_credentials('wrong@gmail.com', "sfdka;kf;12321d")
        expect(user_session).to be_nil
    end
    it "should authenticate when given proper credentials including if extra spaces are around the input" do
      user = User.create(
        first_name:  'Validation',
        last_name: 'Test',
        email: 'example@gmail.com',
        password: 'sfdka;kf;12321',
        password_confirmation: 'sfdka;kf;12321'
          )
        user_session = described_class.authenticate_with_credentials(' example@gmail.com  ', "sfdka;kf;12321")
        expect(user_session).to_not be_nil
    end
    it "should authenticate when given proper credentials including different case of email" do
      user = User.create(
        first_name:  'Validation',
        last_name: 'Test',
        email: 'eXample@gmail.com',
        password: 'sfdka;kf;12321',
        password_confirmation: 'sfdka;kf;12321'
          )
        user_session = described_class.authenticate_with_credentials('exaMple@gmAil.com', "sfdka;kf;12321")
        expect(user_session).to_not be_nil
    end
  end
end
