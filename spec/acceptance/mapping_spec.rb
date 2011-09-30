require 'acceptance/acceptance_helper'

feature "Mapping", %q{
  In order to map data
  As an system user
  I want to manage mappings
} do

  background do
    @map = Mappable::Map.create!(subject: 'account', attr: 'name', from: 'legacy', to: 'current')
  end

  scenario "Add mapping" do
    visit "/map/account/names"

    click_link "New Account Name Mapping"

    fill_in 'From', with: 'Old account name'
    fill_in 'To', with: 'New account name'

    click_button "Create Mapping"

    page.should have_content "Mapping was successfully created."
  end
end
