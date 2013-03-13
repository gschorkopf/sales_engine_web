module SalesEngineWeb
  class Item
    attr_reader :id, :name, :description, :unit_price, :merchant_id

    def initialize(params)
      @id = params[:id]
      @name = params[:name]
      @description = params[:description]
      @unit_price = params[:unit_price]
      @merchant_id = params[:merchant_id]
    end

    def invoice_items
      InvoiceItem.find_all_by_item_id(id)
    end

    def merchant
      Merchant.find(merchant_id)
    end

    def self.create(params)
      Item.new(params).save
    end

    def save
      @id = Item.add(self)
      self
    end

    def self.add(item)
      items.insert(item.to_hash)
    end

    def to_hash
      { :id => id, :name => name,
        :description => description,
        :unit_price => unit_price,
        :merchant_id => merchant_id }
    end

    def to_json(*args)
      { :id => id, :name => name,
        :description => description,
        :unit_price => unit_price,
        :merchant_id => merchant_id }.to_json
    end

    def self.find(id)
      result = items.where(:id => id.to_i).limit(1).first
      new(result) if result
    end

    def self.find_by_name(name)
      result = items.limit(1).where(Sequel.ilike(:name, "%#{name}%")).first
      new(result) if result
    end

    def self.find_all_by_name(name)
      results = items.where(Sequel.ilike(:name, "%#{name}%"))
      results.collect {|result| new(result)} if results
    end

    def self.find_by_description(desc)
      result = items.limit(1).where(Sequel.ilike(:description, "%#{desc}%")).first
      new(result) if result
    end

    def self.find_all_by_description(desc)
      results = items.where(Sequel.ilike(:description, "%#{desc}%"))
      results.collect {|result| new(result)} if results
    end

    def self.find_by_unit_price(price)
      result = items.limit(1).where(unit_price: price).first
      new(result) if result
    end

    def self.find_all_by_unit_price(price)
      results = items.where(unit_price: price)
      results.collect {|result| new(result)} if results
    end

    def self.find_by_merchant_id(id)
      result = items.limit(1).where(merchant_id: id.to_i).first
      new(result) if result
    end

    def self.find_all_by_merchant_id(id)
      results = items.where(merchant_id: id.to_i)
      results.collect {|result| new(result)} if results
    end

    def self.random
      result = items.to_a.sample
      new(result) if result
    end

    def self.items
      Database.items
    end
  end
end