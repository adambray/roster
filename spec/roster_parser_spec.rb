require 'roster_parser'

RSpec.describe RosterParser do
  formats = {
    csv: {
      headers: [:last_name, :first_name, :campus, :favorite_color,
                :date_of_birth],
      delimiter: ",",
      sample_row: {
        first_name: "Draco", last_name: "Malfoy", campus: "Slytherin",
        favorite_color: "Green",  date_of_birth: "1/15/1987"
      }
    },
    dollar: {
      headers: [:last_name, :first_name, :middle_initial, :campus,
                :date_of_birth, :favorite_color],
      delimiter: "$",
      sample_row: {
        first_name: "Draco", last_name: "Malfoy", campus: "Slytherin",
        favorite_color: "Green",  date_of_birth: "1/15/1987", middle_initial: "P"
      }
    },
    pipe: {
      headers: [:last_name, :first_name, :middle_initial, :campus,
                :favorite_color, :date_of_birth],
      delimiter: "|",
      sample_row: {
        first_name: "Draco", last_name: "Malfoy", campus: "Slytherin",
        favorite_color: "Green",  date_of_birth: "1/15/1987", middle_initial: "P"
      }
    }
  }

  context "reading a well-formatted file" do
    # Runs the same tests for each format, using the data
    # defined above.
    formats.each do |format, info|
      context "as #{format}" do
        let(:results) { RosterParser.parse("spec/test_data/good_#{format}.txt",
                              info[:headers], info[:delimiter]) }

        it "returns an array" do
          expect(results).to be_an(Array)
        end

        it "contains as many items as rows in the file" do
          expect(results.length).to eq(3)
        end

        it "returns an array of hashes" do
          # Ensures all rows are hashes, not just the first,
          # last, etc
          expect(results.map(&:class).uniq).to eq([Hash])
        end

        it "returns hashes where the keys are headers" do
          expect(results.first.keys).to eq(info[:headers])
        end

        it "includes hashes that contain the correct data" do
          expect(results).to include(info[:sample_row])
        end

      end
    end
  end

  context "when reading an incorrectly-formatted file" do
    let(:results) { RosterParser.parse("spec/test_data/bad.txt",
                      formats[:csv][:headers], ",") }

    it "should raise an exception if rows don't match columns"  do
      expect {results }.to raise_error(RosterParser::Errors::FileFormat)
    end
  end

end
