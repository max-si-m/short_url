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

    context 'custom short_address' do
      let(:custom_short_url) { 'привет' }
      it 'translit before save' do
        url.short_address = custom_short_url
        expect { url.save }.to change(url, :short_address)
                                .from(custom_short_url)
                                .to( t(custom_short_url) )
      end

      it 'translit before save' do
        url.short_address = custom_short_url
        url.save
        url.short_address = custom_short_url
        expect { url.save }.to change(url, :short_address).to(nil)
      end
    end
  end

  describe 'methods' do
    it '#short_link' do
      url.save
      expect(url.short_link).to eq "#{Rails.application.config.root_url}/#{url.short_address}"
    end

    it '#clicked!' do
      url.save
      expect { url.clicked! }.to change(url, :clicks).by(1)
    end
  end
end
