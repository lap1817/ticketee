require "rails_helper"

RSpec.feature "Project Manager can edit existing project" do
	let(:project) {FactoryGirl.create(:project, name: "Sublime Text 3")}
	let(:user) {FactoryGirl.create(:user)}

	before do
		assign_role!(user, :manager, project)
		login_as(user)
		
		visit "/"
		click_link "Sublime Text 3"
		click_link "Edit Project"
	end

	scenario "with valid attribute" do	
		fill_in "Name", with: "Sublime Text 4 beta"
		click_button "Update Project"
		
		expect(page).to have_content "Project has been updated."
		expect(page).to have_content "Sublime Text 4 beta"
	end
	
	scenario "when providing invalid attributes" do
		fill_in "Name", with: ""
		click_button "Update Project"
		
		expect(page).to have_content "Project has not been updated."
	end
end