require 'rails_helper'

RSpec.describe Url, type: :model do
  let(:url) { build :url }

  describe 'validations' do
    it 'invalid address' do
      url.address = 'invalid_url'
      url.valid?
      expect(url.errors[:address]).not_to be_empty
    end

    it 'valid address' do
      url.valid?
      expect(url.errors[:address]).to be_empty
    end

    it 'short_address' do
      expect { url.save }.to change(url, :short_address)
    end
  end

  describe 'methods' do
    it '#short_link' do
      url.save
      expect(url.short_link).to eq "http://localhost:3000/#{url.short_address}"
    end

    it '#clicked!' do
      url.save
      expect { url.clicked! }.to change(url, :clicks).by(1)
    end
  end
end
