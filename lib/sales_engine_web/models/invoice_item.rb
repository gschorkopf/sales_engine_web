module SalesEngineWeb
  class InvoiceItem
    attr_reader :id, :item_id, :invoice_id, :quantity, :unit_price

    def initialize(params)
      @id = params[:id]
      @item_id = params[:item_id]
      @invoice_id = params[:invoice_id]
      @unit_price = params[:unit_price]
      @quantity = params[:quantity]
    end

    def invoice
      Invoice.find(invoice_id)
    end

    def item
      Item.find(item_id)
    end

    def self.create(params)
      InvoiceItem.new(params).save
    end

    def save
      @id = InvoiceItem.add(self)
      self
    end

    def self.add(invoice_item)
      invoice_items.insert(invoice_item.to_hash)
    end

    def to_hash
      { id: id, invoice_id: invoice_id,
        item_id: item_id, quantity: quantity,
        unit_price: unit_price }
    end

    def to_json(*args)
      { id: id, invoice_id: invoice_id,
        item_id: item_id, quantity: quantity,
        unit_price: unit_price }.to_json
    end

    def self.find(id)
      result = invoice_items.where(:id => id.to_i).limit(1).first
      new(result) if result
    end

    def self.find_by_unit_price(price)
      result = invoice_items.limit(1).where(unit_price: price).first
      new(result) if result
    end

    def self.find_all_by_unit_price(price)
      results = invoice_items.where(unit_price: price)
      results.collect {|result| new(result)} if results
    end

    def self.find_by_invoice_id(id)
      result = invoice_items.limit(1).where(invoice_id: id.to_i).first
      new(result) if result
    end

    def self.find_all_by_invoice_id(id)
      results = invoice_items.where(invoice_id: id.to_i)
      results.collect {|result| new(result)} if results
    end

    def self.find_by_item_id(id)
      result = invoice_items.limit(1).where(item_id: id.to_i).first
      new(result) if result
    end

    def self.find_all_by_item_id(id)
      results = invoice_items.where(item_id: id.to_i)
      results.collect {|result| new(result)} if results
    end

    def self.find_by_quantity(quantity)
      result = invoice_items.limit(1).where(quantity: quantity.to_i).first
      new(result) if result
    end

    def self.find_all_by_quantity(quantity)
      results = invoice_items.where(quantity: quantity.to_i)
      results.collect {|result| new(result)} if results
    end

    def self.random
      result = invoice_items.to_a.sample
      new(result) if result
    end

    def self.invoice_items
      Database.invoice_items
    end
  end
end