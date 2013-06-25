ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"

require 'minitest/autorun'
require 'minitest/rails'
require 'minitest/matchers'

require 'minitest/reporters'
MiniTest::Reporters.use!

require 'valid_attribute'

class ActiveSupport::TestCase
  %w(assignment assignment_type course grade student student_assignment_type_weight).each do |fabricator|
    define_method fabricator do
      instance_variable_get("@#{fabricator}") || instance_variable_set("@#{fabricator}", send("create_#{fabricator}"))
    end
  end

  def grade
    @grade ||= create_grade
  end

  def create_assignment(overrides = {})
    Fabricate :assignment, { :assignment_type => assignment_type }.merge(overrides)
  end

  def create_assignments(count = 2)
    1.upto(count).map { |n| create_assignment(:point_total => 100 + n * 200) }
  end

  def create_assignment_type(overrides = {})
    Fabricate :assignment_type, { :course => course }.merge(overrides)
  end

  def create_course(overrides = {})
    Fabricate :course, overrides
  end

  def create_grade(overrides = {})
    Fabricate :grade, { :gradeable => student, :assignment => assignment }.merge(overrides)
  end

  def create_grades(count = 2)
    create_assignments(count).map { |assignment| create_grade(:assignment => assignment) }
  end

  def create_student(overrides = {})
    Fabricate :student, { :courses => [course] }.merge(overrides)
  end

  def create_student_assignment_type_weight(overrides = {})
    Fabricate :student_assignment_type_weight, { :student => student, :assignment_type => assignment_type }.merge(overrides)
  end
end

class TestStuff
  def self.generate(name, &defaults)
    define_method "create_#{name}" do |overrides = {}, &block|
      Fabricate(name, defaults.call.merge(overrides), &block)
    end

    define_method "initialize_#{name}" do |overrides = {}, &block|
      Fabricate.build(name, defaults.call.merge(overrides), &block)
    end
  end

  generate :course do
    {}
  end

  generate :assignment do
    { :assignment_type => assignment_type, :course => course }
  end

  generate :assignment_type do
    { :course => course }
  end

  generate :grade do
    { :assignment => assignment, :gradeable => student, :course => course }
  end

  %w(assignment assignment_type course grade student student_assignment_type_weight).each do |fabricator|
    attr_writer fabricator

    define_method fabricator do
      instance_variable_get("@#{fabricator}") || instance_variable_set("@#{fabricator}", send("create_#{fabricator}"))
    end
  end

  def assignment_attributes
    { :assignment_type => assignment_type, :course => course }
  end

  def assignment_type_attributes
    { :course => course }
  end

  def grade_attributes
    { :assignment => assignment, :gradeable => student, :course => course }
  end

  def student_attributes
    { :courses => [course] }
  end

  def student_assignment_type_weight_attributes
    { :student => student, :assignment_type => assignment_type }
  end
end

module GradeCraft
  module Generator
    def generate(name, &block)
      yield
    end

    
  end
end
