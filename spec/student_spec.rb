require 'student'

RSpec.describe Student do
  let(:info) { {
    first_name: "Draco", last_name: "Malfoy", campus: "Slytherin",
    favorite_color: "Green",  date_of_birth: "1/15/1987"
  } }

  let(:draco) { Student.new(info) }

  it "has a first name" do
    expect(draco.first_name).to eq("Draco")
  end

  it "has a last name" do
    expect(draco.last_name).to eq("Malfoy")
  end

  it "has a campus" do
    expect(draco.campus).to eq("Slytherin")
  end

  it "converts abbreviations to full campus name" do
    draco = Student.new(info.merge(campus: "SF"))
    expect(draco.campus).to eq("San Francisco")
  end

  it "has a favorite color" do
    expect(draco.favorite_color).to eq("Green")
  end

  it "has a date of birth" do
    expect(draco.date_of_birth).to eq(Date.new(1987, 1, 15))
  end

  it "has a next upcoming birthday" do
    # make a date 1 day in the future
    year = Date.today.year - 15
    month = Date.today.month
    day = Date.today.day + 1
    date_string = Date.new(year, month, day).strftime("%m-%d-%Y")

    new_info = info.merge({date_of_birth: date_string })
    draco = Student.new(new_info)

    current_year = Date.today.year
    expect(draco.upcoming_birthday).to eq(Date.new(current_year, month, day))
  end

  it "returns the next birthday if the birthday has happened this year" do
    # make a date 1 day in the past
    year = Date.today.year - 15
    month = Date.today.month
    day = Date.today.day - 1
    date_string = Date.new(year, month, day).strftime("%m-%d-%Y")

    new_info = info.merge({date_of_birth: date_string })
    draco = Student.new(new_info)

    next_year = Date.today.year + 1
    expect(draco.upcoming_birthday).to eq(Date.new(next_year, month, day))
  end

  it "can be created with a date of birth formatted MM-DD-YYYY" do
    new_info = info.merge({date_of_birth: "1-15-1987"})
    draco = Student.new(new_info)
    expect(draco.date_of_birth).to eq(Date.new(1987, 1, 15))
  end

  it "can be created with a date of birth formatted MM/DD/YYYY" do
    new_info = info.merge({date_of_birth: "1-15-1987"})
    draco = Student.new(new_info)
    expect(draco.date_of_birth).to eq(Date.new(1987, 1, 15))
  end

  it "raises an error for misformatted dates" do
    new_info = info.merge({date_of_birth: "15-01-1987"})
    expect { Student.new(new_info)}.to raise_error(ArgumentError)
  end

  describe "#info_string" do
    it "includes first name" do
      expect(draco.info_string).to include(draco.first_name)
    end

    it "includes last name" do
      expect(draco.info_string).to include(draco.last_name)
    end

    it "includes a well-formatted date of birth" do
      expect(draco.info_string).to include("1/15/1987")
    end

    it "includes favorite color" do
      expect(draco.info_string).to include(draco.favorite_color)
    end

  end
end
