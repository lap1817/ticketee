require "rails_helper"

RSpec.feature "Users can create new projects" do
	scenario "with valid attribute" do
		visit "/"
		click_link "New Project"
		fill_in "Name", with: "Sublime test 3"
		fill_in "Description", with: "a text editor for everyone"
		click_button "Create Project"
		expect(page).to have_content "Project has been created"
		
		project = Project.find_by(name: "Sublime test 3")
		expect(page.current_url).to eq project_url(project)
		title = "Sublime test 3 - Projects - Ticketee"
		expect(page).to have_title title
	end
end