require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do

  describe 'GET #twitter' do

    it 'save question in db' do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      expect { post :complete_auth, :auth => { :provider => 'twitter', :uid => '123456789', info: { :email => 'bad_email' } } }.to_not change(User, :count)
    end
  end

end