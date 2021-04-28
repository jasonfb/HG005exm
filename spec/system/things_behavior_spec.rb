require 'rails_helper'

describe "interaction for ThingsController", type: :feature do
  include HotGlue::ControllerHelper
  

  let!(:thing1) {create(:thing )}
  let!(:thing2) {create(:thing )}
  let!(:thing3) {create(:thing )}

  

  before(:each) do
    login_as()
  end

  describe "index" do
    it "should show me the list" do
      visit things_path

      expect(page).to have_content(thing1.name)
      expect(page).to have_content(thing1.age)
      expect(page).to have_content(thing2.pronoun_id)

    end
  end

  describe "new & create" do
    it "should create a new Thing" do
      visit things_path
      click_link "New Thing"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Thing")]')

      new_name = 'new_test-email@nowhere.com' 
      find("input#thing_name").fill_in(with: new_name)
      find("input#thing_age").fill_in(with: rand(10))
      find("input#thing_pronoun_id").fill_in(with: rand(10))
      click_button "Save"
      expect(page).to have_content("Successfully created")

      expect(page).to have_content(new_name)



    end
  end

  describe "show" do
    it "should return a view form" do
      visit things_path

    end
  end

  describe "edit & update" do
    it "should return an editable form" do
      visit things_path
      find("a.edit-thing-button[href='/things/#{thing1.id}/edit']").click

      expect(page).to have_content("Editing #{thing1.name}")
      new_name = Faker::Name.new 
      find("input[name='thing[name]'").fill_in(with: new_name)


      click_button "Save"
      within("turbo-frame#thing__#{thing1.id} ") do


        expect(page).to have_content(new_name)



      end
    end
  end

  describe "destroy" do
    it "should destroy" do
      visit things_path
      accept_alert do
        find("a.delete-thing-button[href='/things/#{thing1.id}']").click
      end
      expect(page).to_not have_content(thing1.email)
      expect(Thing.where(id: thing1.id).count).to eq(0)
    end
  end
end

