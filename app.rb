$LOAD_PATH.unshift(File.dirname(__FILE__) + "/lib")
require 'student'
require 'roster'
require 'roster_parser'

CSV_HEADERS    = [:last_name, :first_name, :campus, :favorite_color, :date_of_birth]
DOLLAR_HEADERS = [:last_name, :first_name, :middle_initial, :campus, :date_of_birth, :favorite_color]
PIPE_HEADERS   = [:last_name, :first_name, :middle_initial, :campus, :favorite_color, :date_of_birth]

roster = Roster.new

first_students =  RosterParser.parse("data/comma.txt",  CSV_HEADERS,   ",")
second_students = RosterParser.parse("data/dollar.txt", DOLLAR_HEADERS, "$")
third_students =  RosterParser.parse("data/pipe.txt",   PIPE_HEADERS, "|")

all_students_info = first_students + second_students + third_students

all_students_info.each do |info|
  current_student = Student.new(info)
  roster.add(current_student)
end

puts "Output 1:"
puts roster.students(campus: :asc, last_name: :asc).map(&:info_string).join("\n")
puts
puts "Output 2:"
puts roster.students(date_of_birth: :asc).map(&:info_string).join("\n")
puts
puts "Output 3:"
puts roster.students(last_name: :desc).map(&:info_string).join("\n")
