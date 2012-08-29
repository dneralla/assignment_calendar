require "rubygems"
require "sequel"
require "active_support/core_ext"

db_path = File.expand_path('../assignments.db', __FILE__)
Sequel.sqlite(db_path) 

class Assignment < Sequel::Model
  def self.on_date(date)
    self.where(
      {:start_at => date.to_time, 
       :due_at => date.to_time}.sql_or)
  end

  #attr_accessor :name, :course, :due_at, :start_at

  def human_readable_text(date)
    if start_at.to_date == date
      course.present? ? "Start #{name} - (#{course})" : "Start #{name}"
    elsif due_at.to_date == date
      "#{name} due"
    end
  end

  # TODO meta programming could automate this
  def start_at=(time)
    super(time.to_date)
  end

  def due_at=(time)
    super(time.to_date)
  end
end
