module SalesEngineWeb
  class Invoice
    attr_reader :id, :customer_id, :merchant_id, :status

    def initialize(params)
      @id = params[:id]
      @customer_id = params[:customer_id]
      @merchant_id = params[:merchant_id]
      @status = params[:status]
    end

    def transactions
      Transaction.find_all_by_invoice_id(id)
    end

    def invoice_items
      InvoiceItem.find_all_by_invoice_id(id)
    end

    def success?
      transactions.any? {|trans| trans.paid?}
    end

    def pending?
      !success?
    end

    def revenue
      if success?
        invoice_items.inject(0) {|sum, ii| sum + ii.revenue}
      else
        return 0
      end
    end

    def items
      invoice_items.collect {|ii| Item.find(ii.id)}
    end

    def customer
      Customer.find(customer_id)
    end

    def merchant
      Merchant.find(merchant_id)
    end

    def self.random
      invoice = invoices.to_a.sample
      new(invoice) if invoice
    end

    def self.create(params)
      Invoice.new(params).save
    end

    def save
      @id = Invoice.add(self)
      self
    end

    def self.add(invoice)
      invoices.insert(invoice.to_hash)
    end

    def to_hash
      { id: id, customer_id: customer_id,
        merchant_id: merchant_id, status: status }
    end

    def to_json(*args)
      { id: id, customer_id: customer_id,
        merchant_id: merchant_id, status: status }.to_json
    end

    def self.find(id)
      result = invoices.where(id: id.to_i).limit(1).first
      new(result) if result
    end

    def self.find_by_customer_id(id)
      result = invoices.where(customer_id: id.to_i).limit(1).first
      new(result) if result
    end

    def self.find_by_merchant_id(id)
      result = invoices.where(merchant_id: id.to_i).limit(1).first
      new(result) if result
    end

    def self.find_all_by_customer_id(id)
      results = invoices.where(customer_id: id.to_i)
      results.collect {|result| new(result)} if results
    end

    def self.find_all_by_merchant_id(id)
      results = invoices.where(merchant_id: id.to_i)
      results.collect {|result| new(result)} if results
    end

    def self.find_all_by_status(status)
      results = invoices.where(Sequel.ilike(:status, "#{status}"))
      results.collect {|result| new(result)} if results
    end

    def self.invoices
      Database.invoices
    end

  end
end