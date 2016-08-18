require "rails_helper"

RSpec.feature "Admins can crate new users" do
	let(:admin) {FactoryGirl.create(:user, :admin)}
	
	before{
		login_as(admin)
		visit "/"
		click_link "Admin"
		click_link "Users"
		click_link "New User"
	}
	
	scenario "with valid credientials" do
		fill_in "Email", with: "newbie@example.com"
		fill_in "Password", with: "password"
		click_button "Create User"
		expect(page).to have_content "User has been created."
	end
	
	scenario "when the new user is ad admin" do
		fill_in "Email", with: "admin@example.com"
		fill_in "Password", with: "password"
		check "Is an admin?"
		click_button "Create User"
		
		expect(page).to have_content "User has been created."
		expect(page).to have_content "admin@example.com (Admin)"
	end
end