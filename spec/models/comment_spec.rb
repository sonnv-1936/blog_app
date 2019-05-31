require "rails_helper"

RSpec.describe Comment, type: :model do
  context "validates" do
    let(:user) {FactoryBot.create :user}
    let(:entry) {FactoryBot.create :entry, user: user}

    describe ".create" do
      subject {FactoryBot.create :comment, user: user, entry: entry}
      it {is_expected.to be_valid}
    end
  end

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :entry}
  end
end
