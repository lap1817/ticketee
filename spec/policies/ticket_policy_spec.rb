require 'rails_helper'

describe TicketPolicy do
  context "permissions" do
	subject {TicketPolicy.new(user, ticket)}
	
	let(:user) {FactoryGirl.create(:user)}
	let(:project) {FactoryGirl.create(:project)}
	let(:ticket) {FactoryGirl.create(:ticket, project: project)}
	
	context "for anonymous user" do
		let(:user) {nil}
		
		it {should_not permit_action :show}
		it {should_not permit_action :create}
		it {should_not permit_action :update}
		it {should_not permit_action :destroy}
	end
	
	context "for viewers of the project" do
		before {assign_role!(user, :viewer, project)}
		
		it {should permit_action :show}
		it {should_not permit_action :create}
		it {should_not permit_action :update}
		it {should_not permit_action :destroy}
	end
	
	context "for editors of the project" do
		before {assign_role!(user, :editor, project)}
		
		it {should permit_action :show}
		it {should permit_action :create}
		it {should_not permit_action :update}
		it {should_not permit_action :destroy}
		
		context "for editors of who created the ticket" do
			before {ticket.author = user}
			
			it {should permit_action :update}
		end
	end
	
	context "for manager of the project" do
		before {assign_role!(user, :manager, project)}
		
		it {should permit_action :show}
		it {should permit_action :create}
		it {should permit_action :update}
		it {should permit_action :destroy}
	end
	
	context "for manager of other project" do
		before {assign_role!(user, :viewer, FactoryGirl.create(:project))}
		
		it {should_not permit_action :show}
		it {should_not permit_action :create}
		it {should_not permit_action :update}
		it {should_not permit_action :destroy}
	end
	
	context "for admin of the project" do
		let(:user) {FactoryGirl.create(:user, :admin)}
		
		it {should permit_action :show}
		it {should permit_action :create}
		it {should permit_action :update}
		it {should permit_action :destroy}
	end
  end
end
