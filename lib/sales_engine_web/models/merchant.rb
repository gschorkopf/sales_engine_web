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

    def total_items_sold
      items.inject(0) {|sum, item| sum + item.total_quantity }
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

    # def transactions
    #   invoices.map { |inv| inv.transactions.map {|trans| trans_array << trans} }.flatten.compact
    # => shorter, but not cleaner
    # end

    def successful_transactions
      transactions.select {|trans| trans if trans.paid?}
    end

    def customers_with_pending_invoices
      pending_invs = invoices.select {|inv| inv if inv.pending? }
      pending_invs.collect {|inv| inv.customer }
    end

    def self.all_sorted_by_revenue
      all.inject(Hash.new(0)) do |memo, merch|
        memo[merch] += merch.revenue if merch
        memo
      end
    end

    def self.all_sorted_by_items
      all.inject(Hash.new(0)) do |memo, merch|
        memo[merch] += merch.total_items_sold if merch
        memo
      end
    end

    def self.most_revenue(quantity)
      sort_and_output all_sorted_by_revenue, quantity
    end

    def self.most_items(quantity)
      sort_and_output all_sorted_by_items, quantity
    end

    def self.sort_and_output(hash, quantity)
      sorted = []
      hash.sort_by {|k,v| v}.reverse.collect {|k,v| sorted << k}
      sorted[0,quantity.to_i]
    end

    def favorite_customer
      custs = successful_transactions.inject(Hash.new(0)) do |memo, trans|
        memo[trans.customer] += 1
        memo
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

    def self.all
      merchants.order.collect {|row| new(row) }
    end
  end
end