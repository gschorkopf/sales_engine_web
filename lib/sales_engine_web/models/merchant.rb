module SalesEngineWeb
  class Merchant
    attr_reader :id, :name

    def initialize(params)
      @id = params[:id]
      @name = params[:name]
    end

    def items
      Item.find_all_by_merchant_id(id)
    end

    def invoices
      Invoice.find_all_by_merchant_id(id)
    end

    def revenue
      invoices.inject(0) {|sum, inv| sum + inv.revenue }
    end

    def transactions
      trans_array = []
      invoices.each do |inv| 
        inv.transactions.each {|trans| trans_array << trans}
      end
      trans_array
    end

    def successful_transactions
      transactions.select {|trans| trans if trans.paid?}
    end

    def customers_with_pending_invoices
      pending_invs = invoices.select {|inv| inv if inv.pending? }
      pending_invs.collect {|inv| inv.customer }
    end

    def favorite_customer
      custs = Hash.new(0)
      successful_transactions.each do |trans|
        custs[trans.customer] += 1
      end
      custs.sort_by {|k,v| v}.reverse.first.first
    end

    def self.create(params)
      Merchant.new(params).save
    end

    def save
      @id = Merchant.add(self)
      self
    end

    def self.add(merchant)
      merchants.insert(merchant.to_hash)
    end

    def to_hash
      { :id => id, :name => name }
    end

    def self.find(id)
      result = merchants.where(:id => id.to_i).limit(1).first
      new(result) if result
    end

    def self.find_by_name(name)
      result = merchants.limit(1).where(Sequel.ilike(:name, "%#{name}%")).first
      new(result) if result
    end

    def self.find_all_by_name(name)
      results = merchants.where(Sequel.ilike(:name, "%#{name}%"))
      results.collect {|result| new(result)} if results
    end

    def to_json(*args)
      {:id => id, :name => name}.to_json
    end

    def self.random
      result = merchants.to_a.sample
      new(result) if result
    end

    def self.merchants
      Database.merchants
    end
  end
end