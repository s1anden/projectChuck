require 'test_helper'

class TeamTest < ActiveSupport::TestCase

	#Relationship Validations
	should belong_to(:bracket)
	should have_many(:registrations)

	#test bracket_id
	should_not allow_value("bad").for(:bracket_id)
	should_not allow_value(3.2).for(:bracket_id)
	should_not allow_value(false).for(:bracket_id)
	should_not allow_value(nil).for(:bracket_id)

	#test max students
	should allow_value(10).for(:max_students)
	should allow_value(8).for(:max_students)
	should_not allow_value(4).for(:max_students)
	should_not allow_value(nil).for(:max_students)

	#test name
	should validate_presence_of(:name)
	should allow_value("New Orleans Pelicans").for(:name)
	should allow_value("Atlanta Dream").for(:name)
	should_not allow_value("Baltimore Ravens").for(:name)
	should_not allow_value(nil).for(:name)

	#test coach
	should allow_value("John Doe").for(:coach)
	should allow_value(nil).for(:coach)

	context "Creating a team context" do
	    setup do 
	      create_tournament_context
	      create_bracket_context
	      create_team_context
	      create_household_context
	      create_guardian_context
	      create_student_context
	      create_registration_context
	    end
	    
	    teardown do
	      remove_registration_context
	      remove_student_context
	      remove_guardian_context
	      remove_household_context
	      remove_team_context
	      remove_bracket_context
	      remove_tournament_context
	    end

	    should "have a scope to list teams alphabetically" do
	    	assert_equal ["Dallas Mavericks", "Detroit Pistons", "Los Angeles Lakers", "Miami Heat", "New York Knicks", "Orlando Magic", "Washington Wizards"], Team.alphabetical.map[&:name]
	    end

	    should "have a scope to list teams by bracket" do
	    	assert_equal ["Detroit Pistons", "Washington Wizards", "Miami Heat", "Orlando Magic", "Los Angeles Lakers", "New York Knicks", "Dallas Mavericks"], Team.by_bracket
	    end

	    should "have a custom method to show number of students on the team" do
	    	@temp = FactoryGirl.build(:student, household: @grub, first_name: "Zedd", active: false)
	    	@temp_reg = FactoryGirl.build(:registration, student: @temp, team: @heat)
	    	@temp_ted_reg = FactoryGirl.build(:registration, student: @ted, team: @heat)
	    	@temp_jason_reg = FactoryGirl.build(:registration, student: @jason, team: @wizards)
	    	@temp_fred_reg = FactoryGirl.build(:registration, student: @fred, team: @wizards)

	    	assert_equal 2, @heat.current_number_of_students
	    	assert_equal 2, @wizards.current_number_of_students
	    	assert_equal 0, @knicks.current_number_of_students
	    end

	    should "not allow teams to be filled past capacity" do
	    	@temp = FactoryGirl.build(:student, household: @grub, first_name: "Zedd")
	    	@temp_reg = FactoryGirl.build(:registration, student: @temp, team: @heat)
	    	@temp_ted_reg = FactoryGirl.build(:registration, student: @ted, team: @heat)
	    	@temp_ned_reg = FactoryGirl.build(:registration, student: @ned, team: @heat)
	    	@temp_howard_reg = FactoryGirl.build(:registration, student: @howard, team: @heat)
	    	@heat.max_students = 5

	    	@temp2 = FactoryGirl.build(:student, household: @grub, first_name: "Lead")
	    	@temp2_reg = FactoryGirl.build(:registration, student: @temp2, team: @heat)
	    	deny@ temp2_reg.valid?
	    end

	    should "have a custom method to show how many spots remain on a team" do
	    	assert_equal 10, @wizards.remaining_spots
	    	assert_equal 9, @heat.remaining_spots
	    end

	    
	end
end
