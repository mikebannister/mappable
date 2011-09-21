require 'acceptance/acceptance_helper'

feature "Map", %q{
  In order to map different types of data
  As an system administrator
  I want to manage maps
} do

  scenario "Add map" do
    visit "/mappable"

    click_link "New Map"
    
    fill_in 'Subject', with: 'account'
    fill_in 'Attribute', with: 'name'
    fill_in 'From name', with: 'legacy'
    fill_in 'To name', with: 'system'
    
    click_button "Create Map"
    
    page.should have_content "Map was successfully created."
  end

  context "existing map" do
    background do
      @map = Mappable::Map.create!(subject: 'account', attr: 'name', from: 'legacy', to: 'current')
    end

    scenario "Edit map" do
      visit "/mappable"

      click_link "Edit"
    
      fill_in 'Subject', with: 'accountEDITED'
      fill_in 'Attribute', with: 'nameEDITED'
      fill_in 'From name', with: 'legacyEDITED'
      fill_in 'To name', with: 'systemEDITED'
    
      click_button "Update Map"
    
      page.should have_content "Map was successfully updated."
      
      page.should have_content "accountEDITED"
      page.should have_content "nameEDITED"
      page.should have_content "legacyEDITED"
      page.should have_content "systemEDITED"
    end
  end
end
