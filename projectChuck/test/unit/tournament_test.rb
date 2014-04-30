require 'test_helper'

class TournamentTest < ActiveSupport::TestCase
  # Relationship validations
  should have_many(:brackets)

  #test end_date
  should allow_value(Date.today).for(:end_date)
  should allow_value(2.days.ago.to_date).for(:end_date)
  should allow_value(3.days.from_now.to_date).for(:end_date)
  should_not allow_value(nil).for(:end_date)
  should_not allow_value("bad").for(:end_date)
  should_not allow_value(5).for(:end_date)

  #test start_date
  should allow_value(Date.today).for(:start_date)
  should allow_value(2.days.ago.to_date).for(:start_date)
  should allow_value(3.days.from_now.to_date).for(:start_date)
  should_not allow_value(nil).for(:start_date)
  should_not allow_value("bad").for(:start_date)
  should_not allow_value(5).for(:start_date)

  context "Creating a team context" do
	    setup do 
	      create_tournament_context
	      # create_bracket_context
	      # create_team_context
	      # create_household_context
	      # create_guardian_context
	      # create_student_context
	      # create_registration_context
	    end
	    
	    teardown do
	      # remove_registration_context
	      # remove_student_context
	      # remove_guardian_context
	      # remove_household_context
	      # remove_team_context
	      # remove_bracket_context
	      remove_tournament_context
	    end

	    should "require start_date to be before end_date" do
	    	@tourn1 = FactoryGirl.build(:tournament, start_date: Date.today, end_date: 8.weeks.from_now.to_date)
	    	@tourn2 = FactoryGirl.build(:tournament, start_date: Date.today, end_date: Date.today)
	    	@tourn3 = FactoryGirl.build(:tournament, start_date: Date.today, end_date: 3.days.ago.to_date)

	    	assert @tourn1.valid?
	    	deny @tourn2.valid?
	    	deny @tourn3.valid?
	    end

	    should "have a scope to order tournaments by date" do
	    	assert_equal [2.weeks.from_now, 52.weeks.from_now], Tournament.by_date.map[&:start_date]
	    end

	    should "have a method to give the name of the tournament" do
	    	assert_equal "Project C.H.U.C.K. 2014", @tourn.name
	    end

	    should "have a method to return the number of students registered for a tournament" do
	    	assert_equal 3, @tourn.number_of_students
	end
end
