require "rails_helper"

RSpec.describe Entry, type: :model do
  context "validates" do
    let(:user) {FactoryBot.create :user}
    subject {FactoryBot.create :entry, user: user}

    describe ".create" do
      it {is_expected.to be_valid}
    end

    it {is_expected.to validate_presence_of :title}
    it {is_expected.to validate_presence_of :body}
  end

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to have_many :comments}
  end

  context "scopes" do
    describe ".latest" do
      it {expect(Entry.latest.to_sql)
        .to eq "SELECT `entries`.* FROM `entries` ORDER BY `entries`.`created_at` DESC"}
    end
  end
end
