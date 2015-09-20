require 'rails_helper'

RSpec.describe UrlsController, type: :controller do
  describe 'GET #redirect' do
    let(:url) { create :url }
    subject { get :redirect, short_address: url.short_address }

    it 'correct short_address' do
      expect(subject).to redirect_to(url.address)
    end

    it 'invalid short_address' do
      get :redirect, short_address: 12_345
      expect(response).to have_http_status(404)
    end
  end

  describe 'POST #new' do
    let(:url) { build :url }
    subject(:valid) { post :create, url: { address: url.address }, format: :js }
    subject(:invalid) { post :create, url: { address: nil }, format: :js }

    it 'valid creation' do
      expect { valid }.to change(Url, :count).by(1)
    end

    it 'invalid creation' do
      expect { invalid }.not_to change(Url, :count)
    end
  end

  describe 'GET #show' do
    let(:url) { create :url }
    subject { post :show, id: url.id }

    it 'is removed' do
      expect { subject }.to raise_error(ActionController::UrlGenerationError)
    end
  end
end
