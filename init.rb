# only needs to run once to create db / table

require "rubygems"
require "sequel"

DB = Sequel.sqlite('assignments.db') 

DB.create_table :assignments do
  primary_key :id
  String :name, :null => false
  String :course
  DateTime :due_at
  DateTime :start_at
end
