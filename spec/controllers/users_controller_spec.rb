require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to render_template(:new)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    let(:user) { FactoryGirl.build(:user) }
    context 'with invalid params' do
      it 'tries to validate the presence of username and password' do
        post(:create, params: {
          user: {
            username: 'sicko',
            password: 'short'
          }
        })
        expect(response).to render_template('new')
        expect(flash[:errors]).to be_present
      end
    end

    context 'with valid params' do
      it 'redirects to the goals#index page' do
        post(:create, params: {
          user: {
            username: 'sicko',
            password: 'password'
          }
        })
        expect(response).to redirect_to(goals_url)
      end
    end
  end

end
