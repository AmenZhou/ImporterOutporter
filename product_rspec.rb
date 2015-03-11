require "rspec"
require_relative "./main.rb"

describe "input csv file" do
  context "to generate params" do
    before :all do
      @params = csv_parse("./input.csv")
    end

    it "should return an array" do
      expect(@params.class).to eq(Array)
    end

    it "should have 14 elements" do
      expect(@params.count).to eq(14)
    end

    it "each element is a hash" do
      expect(@params[0].class).to eq(Hash)
    end
  end

  context "to generate product records" do
    before :all do
      import_data("./input.csv", :csv)
      @products = Product.all
    end

    it "should have 14 records" do
      expect(@products.count).to eq(14)
    end

    it "should save all the records" do
      @products.each do |product|
        expect(product.class).to eq(Product)
      end
    end

    context "which includes" do
      it "item id is a number" do
        @products.each do |product|
          expect(product.item_id).to match(/\A\d+\Z/)
          expect(product.item_id).to_not match(/\A\D+\Z/)
        end
      end

      it "item id is unique" do
        expect(@products.map(&:item_id).uniq.count).to eq(14)
      end

      it "price is a number" do
        @products.each do |product|
          expect(product.price).to match(/\A\d+\.\d+\Z/) unless product.price.empty?
        end
      end

      it "price type is valid" do
        @products.each do |product|
          expect(product.price_type).to match(/[system|open]/)
        end
      end
    end
  end

  context "output product to json" do
    before :all do
      @json = Product._to_json
    end

    context "could be parsed to an array" do
      before :all do
        @json = JSON.parse(@json)
      end

      it "include all records" do
        expect(@json.class).to eq(Array)
        expect(@json.count).to eq(14)
      end

      it "has unique records" do
        expect(@json.map{ |product| product["id"] }.uniq.count).to eq(14)
      end
    end
  end
end

