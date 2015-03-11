#!/usr/bin/env ruby

require_relative "./product"
require_relative "./csv_parse"
include CsvParse

# use different parser for different file type
# add new parser to extend this function
def import_data path, file_type
  if file_type == :csv
    csv_parse(path).each { |params| Product.new(params).save }
  elsif file_type == :xls
    #xls_parse(path)
  end
end

#import_data("./input.csv", :csv)
#p Product._to_json
