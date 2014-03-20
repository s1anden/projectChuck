ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  # Prof. H's deny method to improve readability of tests
  def deny(condition, msg="")
    # a simple transformation to increase readability IMO
    assert !condition, msg
  end
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def create_student_context
    @ed = FactoryGirl.create(:student)
    @ted = FactoryGirl.create(:student, first_name: "Ted", cell_phone: "412-268-2323")
    @fred = FactoryGirl.create(:student, first_name: "Fred", grade_integer:7, dob:11.years.ago.to_date)
    @ned = FactoryGirl.create(:student, first_name: "Ned", date_of_birth: 13.years.ago.to_date, school:"Pittsburgh High School", school_county:"Allegheny")
    @noah = FactoryGirl.create(:student, first_name: "Noah", last_name: "Ark", grade_integer:5, date_of_birth: 9.years.ago.to_date, emergency_contact_name: "Hannah Ark")
    @howard = FactoryGirl.create(:student, first_name: "Howard", last_name: "Marcus", date_of_birth:169.months.ago.to_date, emergency_contact_phone: { rand(10 ** 10).to_s.rjust(10,'0') })
    @jen = FactoryGirl.create(:student, first_name: "Jen", last_name: "Hanson", gender:false, allergies:"nuts,shrimp,lemons", date_of_birth: 167.months.ago.to_date)
    @julie = FactoryGirl.create(:student, first_name: "Julie", last_name: "Henderson", gender:false, medications:"insulin", date_of_birth: 1039.weeks.ago.to_date, waiver_signed: false)
    @jason = FactoryGirl.create(:student, first_name: "Jason", last_name: "Hoover", gender:false, medications:"theophyline", active: false, date_of_birth: 36.years.ago.to_date)
  end
    
  def remove_student_context
    @ed.delete
    @ted.delete
    @fred.delete
    @ned.delete
    @noah.delete
    @jen.delete
    @howard.delete
    @julie.delete
    @jason.delete
  end

  def create_registration_context

  end 

  def remove_registration_context
  	@reg_ed.delete
  end

  def create_team_context

  end

  def remove_team_context

  end

  def create_bracket_context

  end

  def remove_bracket_context

  end

  def create_household_context

  end

  def remove_household_context

  end

  def create_guardian_context

  end

  def remove_guardian_context

  end

  def create_user_context

  end

  def remove_user_context

  end
end
