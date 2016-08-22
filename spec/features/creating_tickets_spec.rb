require "rails_helper"

RSpec.feature "Users can create new tickets" do
	let(:user) {FactoryGirl.create(:user)}

	before do
		project = FactoryGirl.create(:project, name: "Internet Explore")
		login_as(user)
		assign_role!(user, :viewer, project)
		
		visit project_path(project)
		click_link "New Ticket"
	end
	
	scenario "with valid attributes" do
		fill_in "Name", with: "Non-standards compliances"
		fill_in "Description", with: "My pages are ugly!"
		click_button "Create Ticket"
		
		expect(page).to have_content "Ticket has been created."
		within("#ticket") do
			expect(page).to have_content "Author: #{user.email}"
		end
	end
	
	scenario "with invalid attributes" do
		click_button "Create Ticket"
		
		expect(page).to have_content "Ticket has not been created."
		expect(page).to have_content "Name can't be blank"
		expect(page).to have_content "Description can't be blank"
	end
	
	scenario "with an invalid description" do
		fill_in "Name", with: "Non0standards compliances"
		fill_in "Description", with: "It sucks"
		click_button "Create Ticket"
		
		expect(page).to have_content "Ticket has not been created"
		expect(page).to have_content "Description is too short"
	end
end