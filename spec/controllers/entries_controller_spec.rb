require "rails_helper"

RSpec.describe EntriesController, type: :controller do
  let(:user) {FactoryBot.create :user}
  let(:admin) {FactoryBot.create :admin}
  let!(:entry) {FactoryBot.create :entry, user: user}
  let(:entry_attributes) {FactoryBot.attributes_for :entry, user: user}

  describe "GET #index" do
    it do
      get :index
      expect(response).to render_template "index"
    end
  end

  describe "GET #show" do
    it do
      get :show, params: {entry_id: entry}
      expect(response).to render_template "show"
    end
  end

  describe "GET #new" do
    describe "when user not sign in" do
      it do
        get :new
        expect(response).to redirect_to root_path
      end
    end

    describe "when user signed in" do
      before {@request.session["user_id"] = user.id}
      it do
        get :new
        expect(response).to render_template "new"
      end
    end
  end

  describe "POST #create" do
    describe "when user not sign in" do
      it do
        post :create, params: {entry: entry_attributes}
        expect(response).to redirect_to root_path
      end
    end
    describe "when user signed in" do
      before {@request.session["user_id"] = user.id}
      describe "create invalid entry" do
        it do
          entry_attributes[:title] = ""
          post :create, params: {entry: entry_attributes}
          expect(response).to render_template "new"
        end
      end
      describe "create valid entry" do
        it do
          expect {post :create, params: {entry: entry_attributes}}
            .to change {Entry.count}.by 1
        end
      end
    end
  end

  describe "DELETE #destroy" do
    describe "when user not sign in" do
      it do
        delete :destroy, params: {entry_id: entry.id}
        expect(response).to redirect_to root_path
      end
    end

    describe "when user is not administrator" do
      before {@request.session["user_id"] = user.id}
      it do
        delete :destroy, params: {entry_id: entry.id}
        expect(response).to redirect_to root_path
      end
    end

    describe "when user is administrator" do
      before {@request.session["user_id"] = admin.id}
      it do
        expect {delete :destroy, params: {entry_id: entry.id}}
          .to change {Entry.count}.by -1
      end
    end
  end
end
