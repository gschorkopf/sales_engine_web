require './lib/sales_engine_web/models/database'

module SalesEngineWeb
  class Invoice
    attr_reader :id, :customer_id, :merchant_id

    def initialize(params)
      @id = params[:id]
      @customer_id = params[:customer_id]
      @merchant_id = params[:merchant_id]
    end

    def self.random
      invoices.sample
    end

    def self.create(invoice)
      invoice = Invoice.new(invoice)
      invoices << invoice
      invoice
    end

    def self.find(id)
      invoices.find {|i| i.id == id}
    end

    def self.find_by_customer_id(id)
      invoices.find {|i| i.customer_id == id.to_i}
    end

    def self.find_by_merchant_id(id)
      invoices.find {|i| i.merchant_id == id.to_i}
    end

    def self.invoices
      @invoices ||= []
    end

  end
end