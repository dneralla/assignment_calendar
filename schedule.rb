#TODO in another job make a schedule emailer to notify me of assignments on the date
require_relative './assignment.rb'

class Schedule
  def self.print_schedule
    (start_date .. end_date).each do |date|
      if (assignments = Assignment.on_date(date)).present?
        puts "\n On #{date.to_s}"
        puts "---------------"
        assignments.each {|a| puts a.human_readable_text(date)}
      end
    end
    puts "\n"
  end

  def self.start_date
    [Assignment.order(:start_at).limit(1).first.start_at,
     Assignment.order(:due_at).limit(1).first.due_at].
     compact.min.to_date
  end

  def self.end_date
    [Assignment.reverse_order(:start_at).limit(1).first.start_at,
     Assignment.reverse_order(:due_at).limit(1).first.due_at].
     compact.max.to_date
  end
end
