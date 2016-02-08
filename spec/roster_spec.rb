require 'roster'

RSpec.describe Roster do
  let(:roster) { Roster.new }

  let!(:hermione) { Student.new(last_name: "Granger",
    first_name: "Hermione", campus: "Gryffendor", favorite_color: "Maroon",
    date_of_birth: "5/2/1986") }
  let!(:harry)    { Student.new(last_name: "Potter", 
    first_name: "Harry", campus: "Gryffendor", favorite_color: "Burgundy",
    date_of_birth: "9/29/1984") }
  let!(:draco)    { Student.new(last_name: "Malfoy",
    first_name: "Draco", campus: "Slytherin", favorite_color: "Green",
    date_of_birth: "1/15/1987") }
  let!(:luna)     { Student.new(last_name: "Lovegood",
    first_name: "Luna", campus: "Ravenclaw", favorite_color: "Gold",
    date_of_birth: "8/15/1986") }

  describe "#add" do
    it "returns true when a student is passed in" do
      expect(roster.add(hermione)).to eq(true)
    end

    it "returns false when a non-student is passed in" do
      expect(roster.add("Harry Potter")).to eq(false)
    end
  end

  describe "#students" do
    it "returns an array" do
      expect(roster.students).to be_an(Array)
    end

    it "contains added students" do
      roster.add(hermione)
      expect(roster.students).to include(hermione)
    end

    it "only contains students added" do
      roster.add(hermione)
      expect(roster.students).to_not include(luna)
    end

    it "contains all added students" do
      roster.add(hermione)
      roster.add(draco)
      roster.add(luna)
      expect(roster.students.length).to eq(3)
    end

    context "when including sorting fields" do
      before(:each) {
        roster.add(hermione)
        roster.add(draco)
        roster.add(luna)
        roster.add(harry)
       }

      it "returns a list sorted by one field ascending" do
        sorted = roster.students({last_name: :asc})
        expect(sorted).to eq([hermione, luna, draco, harry])
      end

      it "returns a list sorted by one field descending" do
        sorted = roster.students({last_name: :desc})
        expect(sorted).to eq([harry, draco, luna, hermione])
      end

      it "returns a list sorted by multiple fields" do
        sorted = roster.students({campus: :desc, last_name: :asc})
        expect(sorted).to eq([draco, luna, hermione, harry])
      end

      it "returns a list sorted by date of birth" do
        sorted = roster.students({date_of_birth: :asc})
        expect(sorted).to eq([harry, hermione, luna, draco])
      end

      context "with incorrect sorting options" do
        it "raises an argument error if fields aren't properties of students" do
          expect {roster.students(patronus: :desc)}.to raise_error(ArgumentError)
        end

        it "raises an argument error if sort properties aren't :asc or :desc" do
          expect {roster.students(first_name: :des)}.to raise_error(ArgumentError)
        end

      end
    end
  end
end
