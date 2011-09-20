require 'acceptance/acceptance_helper'

feature "Add mapping", %q{
  In order to map data
  As an system user
  I want to add new mappings to the system
} do

  background do
    @map = Mappable::Map.create!(subject: 'account', attr: 'name', from: 'legacy', to: 'current')
  end

  scenario "Add mapping" do
    visit "/mappable/account/names"
    click_link "New Account Name Mapping"

    fill_in 'From', with: 'Old account name'
    fill_in 'To', with: 'New account name'

    click_button "Create Mapping"

    page.should have_content "Mapping was successfully created."
  end
end
