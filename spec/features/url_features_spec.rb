require 'rails_helper'

feature 'Url' do
  given(:url) { build :url }

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

  scenario 'invalid creation', js: true do
    visit root_path

    page.accept_alert 'Only urls! :)' do
      find(:xpath, "//input[@value='SHORTEN']").click
    end

    # for validation short_address
    url.save

    expect(page).not_to have_content("Address: #{url.address}")
    expect(page).not_to have_content("Short address: #{url.short_link}")
    expect(page).not_to have_content('Clicks: 0')
  end
end
