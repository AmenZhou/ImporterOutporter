class Product
  require 'byebug'
  require_relative "./string"
  require_relative "./csv_parse"
  require 'json'
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
      csv_parse(path).each { |params| new(params).save }
    elsif file_type == :xls
      #generate_params_by_xls
    end
  end

  def self.all
    @@products
  end

  def save
    @@products ||= []
    @@products << self
  end

  def to_hash
    {
     id: item_id, description: description, price: price, cost: cost,
     price_type: price_type, quantity_on_hand: quantity_on_hand,
     modifiers: [{name: modifier_1_name, price: modifier_1_price},
                 {name: modifier_2_name, price: modifier_2_price},
                 {name: modifier_3_name, price: modifier_3_price}]
    }
  end

  def self.to_hash
    all.map { |product| product.to_hash }
  end

  def self._to_json
    to_hash.to_json
  end
end
