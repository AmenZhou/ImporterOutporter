class Product
  require_relative "./string"
  require 'json'

  attr_accessor :item_id, :description, :price, :cost, :price_type, :quantity_on_hand,
    :modifier_1_name, :modifier_1_price, :modifier_2_name, :modifier_2_price, :modifier_3_name, :modifier_3_price


  def initialize params = {}
    params.each do |k, v|
      self.send("#{k}=", v)
    end
  end

  def self.all
    @@products
  end

  def save
    method(@@before_save).call

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

  private

  def self.before_save callback
    @@before_save = callback
  end

  before_save :remove_dollar

  # define callback
  def remove_dollar
    %w(price cost modifier_1_price modifier_2_price modifier_3_price).each do |_price|
      self.send(_price).gsub!("$", "") if self.send(_price)
    end
  end
end
