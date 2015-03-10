class Product
  require 'byebug'
  require_relative "./string"
  require_relative "./csv_parse"
  extend CsvParse

  attr_accessor :item_id, :description, :price, :cost, :price_type, :quantity_on_hand,
    :modifier_1_name, :modifier_1_price, :modifier_2_name, :modifier_2_price, :modifier_3_name, :modifier_3_price

  def initialize params = {}
    params.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  # use different parser for different file type
  # add new parser to extend this function
  def self.import_data path, file_type
    if file_type == :csv
      csv_parse(path).each { |params| new(params) }
    elsif file_type == :xls
      #generate_params_by_xls
    end
  end
end
