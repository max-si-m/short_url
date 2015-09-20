require 'rails_helper'

feature 'Url' do
  given(:url) { build :url, short_address: 'test' }

  scenario 'valid creation', js: true do
    visit root_path
    fill_in 'url_address', with: url.address
    find(:xpath, "//input[@value='SHORTEN']").click

    # for validation short_address
    url.save

    expect(page).to have_content("Address: #{url.address}")
    expect(page).to have_content("Short address: #{url.short_link}")
    expect(page).to have_content('Clicks: 0')
  end

  scenario 'creation with short_address', js: true do
    visit root_path
    fill_in 'url_address', with: url.address
    fill_in 'url_short_address', with: url.short_address
    find(:xpath, "//input[@value='SHORTEN']").click

    # for validation short_address
    url.save

    expect(page).to have_content("Address: #{url.address}")
    expect(page).to have_content("Short address: #{url.short_link}")
    expect(page).to have_content('Clicks: 0')
  end

  scenario 'duplication short_address', js: true do
    url.save
    custom_url = create :url, short_address: 'test'

    visit root_path
    fill_in 'url_address', with: custom_url.address
    fill_in 'url_short_address', with: custom_url.short_address
    find(:xpath, "//input[@value='SHORTEN']").click

    expect(page).to have_content("Address: #{custom_url.address}")
    expect(page).to have_content("Short address: #{custom_url.short_link}")
    expect(page).to have_content('Clicks: 0')
  end
end
