require 'csv'

# Input: a file name with contents delimited by any valid delimiter character,
# as well as an array of names for the headers of that file
# Output: an array of hashes representing the data in each row of the file
# Raises: RosterParser::FileFormatError if the headers don't match up with the
# data in number
class RosterParser
  def self.parse(file_name, headers, delimiter=",")
    rows = CSV.read(file_name, col_sep: delimiter)

    labeled_rows = []
    rows.each do |row|
      raise Errors::FileFormat if headers.length != row.length

      # remove whitespace around delimeter
      row.map!{ |value| value.strip }

      # convert row into a hash using headers array as keys
      labeled_rows << Hash[headers.zip(row)]
    end

    return labeled_rows
  end

  module Errors
    class FileFormat < StandardError
      def message
        "Format Error: The number of header columns must match the number of columns in the data"
      end
    end
  end
end
