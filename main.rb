#!/usr/bin/env ruby

require_relative "./product"

Product.import_data("/home/action/input.csv", :csv)
p Product._to_json
