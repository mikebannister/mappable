require 'acceptance/acceptance_helper'

feature "Add mapping", %q{
  In order to map data
  As an system user
  I want to add new mappings to the system
} do

  background do
    @map = Mappable::Map.create!(from: 'legacy', to: 'current', name: 'account', attr: 'name')
  end

  scenario "Add mapping" do
    visit "/mappable/mappings"

    click_link "New Mapping"

    fill_in 'From', with: 'Old account name'
    fill_in 'To', with: 'New account name'
    fill_in 'Map', with: @map.id

    click_button "Create Mapping"

    page.should have_content "Mapping was successfully created."
  end
end
