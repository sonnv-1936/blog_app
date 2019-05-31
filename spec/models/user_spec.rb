require "rails_helper"

RSpec.describe User, type: :model do
  context "validates" do
    subject {FactoryBot.create :user}

    describe ".create" do
      it {is_expected.to be_valid}
    end

    describe "#name" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_length_of :name}
    end

    describe "#email" do
      it {is_expected.to validate_presence_of :email}
      it {is_expected.to validate_length_of :email}
      it {is_expected.to allow_value("example@email.address.com").for :email}
      it {is_expected.to_not allow_value("invalid@email_address_com").for :email}
      it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
    end

    describe "#password" do
      subject {FactoryBot.build :user, password: ""}
      it {is_expected.to validate_presence_of :password}
      it {is_expected.to validate_length_of :password}
      it {is_expected.to have_secure_password}
    end
  end

  context "associations" do
    it {is_expected.to have_many :entries}
    it {is_expected.to have_many :comments}
    it {is_expected.to have_many :active_relationships}
    it {is_expected.to have_many :passive_relationships}
    it {is_expected.to have_many :following}
    it {is_expected.to have_many :followers}
  end
end
