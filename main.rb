#!/usr/bin/env ruby

require_relative "./product"

p Product.import_data("/home/action/input.csv", :csv)
