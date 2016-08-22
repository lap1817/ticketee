require "rails_helper"

RSpec.feature "Users can delete ticket" do
	let(:project) {FactoryGirl.create(:project)}
	let(:user) {FactoryGirl.create(:user)}
	let(:ticket) {FactoryGirl.create(:ticket, project: project, author: user)}
	
	before do
		login_as(user)
		assign_role!(user, :viewer, project)
		visit project_ticket_path(project, ticket)
	end
	
	scenario "successfully" do
		click_link "Delete Ticket"
		
		expect(page).to have_content "Ticket has been deleted."
		expect(page.current_url).to eq project_url(project)
	end

end