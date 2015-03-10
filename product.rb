class Product
  require 'byebug'
  require_relative "./string"

  attr_accessor :item_id, :description, :price, :cost, :price_type, :quantity_on_hand,
    :modifier_1_name, :modifier_1_price, :modifier_2_name, :modifier_2_price, :modifier_3_name, :modifier_3_price

  def initialize params = {}
    params.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  def self.import_data path, file_type
    if file_type == :csv
      generate_params_by_csv(path).each { |params| new(params) }
    elsif file_type == :xls
      #generate_params_by_xls
    end
  end

  def self.generate_params_by_csv path
    lines = File.readlines(path)
    single_record = {}
    titles = lines.shift.gsub("\n", '').split(',').map(&:underscore)

    lines.map do |row|
      data = row.gsub("\n", '').split(',')
      titles.each do |title|
        single_record[title] = data.shift
      end
      single_record
    end
  end
end
