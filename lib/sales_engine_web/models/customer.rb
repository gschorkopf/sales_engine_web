module SalesEngineWeb
  class Customer
    attr_reader :id, :first_name, :last_name

    def initialize(params)
      @id = params[:id]
      @first_name = params[:first_name]
      @last_name = params[:last_name]
    end

    def invoices
      Invoice.find_all_by_customer_id(id)
    end

    def transactions
      # invoices.collect {|invoice| invoice.transactions }
      trans_array = []
      invoices.each do |inv| 
        inv.transactions.each {|trans| trans_array << trans}
      end
      trans_array
    end

    def self.random
      result = customers.to_a.sample
      new(result) if result
    end

    def self.find(id)
      customer = customers.where(id: id.to_i).limit(1).first
      new(customer) if customer
    end

    def self.find_by_first_name(name)
      customer = customers.where(Sequel.ilike(:first_name, "%#{name}%")).limit(1).first
      new(customer) if customer
    end

    def self.find_by_last_name(name)
      customer = customers.where(Sequel.ilike(:last_name, "%#{name}%")).limit(1).first
      new(customer) if customer
    end

    def self.find_all_by_first_name(name)
      results = customers.where(Sequel.ilike(:first_name, "%#{name}%"))
      results.collect {|c| new(c) } if results
    end

    def self.find_all_by_last_name(name)
      results = customers.where(Sequel.ilike(:last_name, "%#{name}%"))
      results.collect {|c| new(c) } if results
    end

    def self.create(params)
      Customer.new(params).save
    end

    def save
      @id = Customer.add(self)
      self
    end

    def self.add(customer)
      customers.insert(customer.to_hash)
    end

    def to_hash
      { :id => id, :first_name => first_name,
        :last_name => last_name }
    end

    def to_json(*args)
      { :id => id, :first_name => first_name,
        :last_name => last_name }.to_json
    end

    def self.customers
      Database.customers
    end
  end
end