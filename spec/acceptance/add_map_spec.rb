require 'acceptance/acceptance_helper'

feature "Add map", %q{
  In order to map different types of data
  As an system administrator
  I want to add new maps to the system
} do

  scenario "Add map" do
    visit "/mappable/maps"

    click_link "New Map"

    fill_in 'Subject', with: 'account'
    fill_in 'Attribute', with: 'name'
    fill_in 'From name', with: 'legacy'
    fill_in 'To name', with: 'system'

    click_button "Create Map"

    page.should have_content "Map was successfully created."
  end
end
