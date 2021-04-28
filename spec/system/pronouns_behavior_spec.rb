require 'rails_helper'

describe "interaction for PronounsController", type: :feature do
  include HotGlue::ControllerHelper
  

  let!(:pronoun1) {create(:pronoun )}
  let!(:pronoun2) {create(:pronoun )}
  let!(:pronoun3) {create(:pronoun )}

  

  before(:each) do
    login_as()
  end

  describe "index" do
    it "should show me the list" do
      visit pronouns_path

      expect(page).to have_content(pronoun3.name)

    end
  end

  describe "new & create" do
    it "should create a new Pronoun" do
      visit pronouns_path
      click_link "New Pronoun"
      expect(page).to have_selector(:xpath, './/h3[contains(., "New Pronoun")]')

      new_name = 'new_test-email@nowhere.com' 
      find("input#pronoun_name").fill_in(with: new_name)
      click_button "Save"
      expect(page).to have_content("Successfully created")

      expect(page).to have_content(new_name)

    end
  end

  describe "show" do
    it "should return a view form" do
      visit pronouns_path

    end
  end

  describe "edit & update" do
    it "should return an editable form" do
      visit pronouns_path
      find("a.edit-pronoun-button[href='/pronouns/#{pronoun1.id}/edit']").click

      expect(page).to have_content("Editing #{pronoun1.name}")
      new_name = Faker::Name.new 
      find("input[name='pronoun[name]'").fill_in(with: new_name)
      click_button "Save"
      within("turbo-frame#pronoun__#{pronoun1.id} ") do


        expect(page).to have_content(new_name)

      end
    end
  end

  describe "destroy" do
    it "should destroy" do
      visit pronouns_path
      accept_alert do
        find("a.delete-pronoun-button[href='/pronouns/#{pronoun1.id}']").click
      end
      expect(page).to_not have_content(pronoun1.email)
      expect(Pronoun.where(id: pronoun1.id).count).to eq(0)
    end
  end
end

