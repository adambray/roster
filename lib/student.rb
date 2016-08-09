class Student
  ATTRS = [:first_name, :last_name, :campus, :favorite_color, :date_of_birth].freeze
  attr_reader *ATTRS

  def initialize(info = {})
    @first_name     = info[:first_name]
    @last_name      = info[:last_name]
    @date_of_birth  = parse_date(info[:date_of_birth])
    @campus         = convert_to_campus(info[:campus])
    @favorite_color = info[:favorite_color]
  end

  def info_string
    formatted_date_of_birth = date_of_birth.strftime("%-m/%-d/%Y")
    "#{last_name} #{first_name} #{campus} #{formatted_date_of_birth} #{favorite_color}"
  end

  def upcoming_birthday
    day = date_of_birth.day
    month = date_of_birth.month

    today = Date.today
    birthday_this_year = Date.new(today.year, month, day)

    if birthday_this_year < today
      return Date.new(today.year + 1, month, day)
    else
      return Date.new(today.year, month, day)
    end
  end

  private
  def convert_to_campus(original)
    campuses = {
      "LA"  => "Los Angeles",
      "NYC" => "New York City",
      "SF" => "San Francisco",
     }

    campuses.fetch(original, original)
  end

  def parse_date(date_string)
    delimiter = date_string.include?("-") ? "-" : "/"
    date_components = date_string.split(delimiter)

    month = date_components[0].to_i
    day   = date_components[1].to_i
    year  = date_components[2].to_i

    return Date.new(year, month, day)
  end
end
