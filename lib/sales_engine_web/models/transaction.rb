module SalesEngineWeb
  class Transaction
    attr_reader :id, :invoice_id, :result, :credit_card_number, :credit_card_expiration_date

    def initialize(params)
      @id = params[:id]
      @invoice_id = params[:invoice_id]
      @result = params[:result]
      @credit_card_number = params[:credit_card_number]
      @credit_card_expiration_date = params[:credit_card_expiration_date]
    end

    def invoice
      Invoice.find(invoice_id)
    end

    def self.create(params)
      Transaction.new(params).save
    end

    def save
      @id = Transaction.add(self)
      self
    end

    def self.add(transaction)
      transactions.insert(transaction.to_hash)
    end

    def to_hash
      { id: id, invoice_id: invoice_id,
        credit_card_number: credit_card_number,
        credit_card_expiration_date: credit_card_expiration_date,
        result: result }
    end

    def to_json(*args)
      { id: id, invoice_id: invoice_id,
        credit_card_number: credit_card_number,
        credit_card_expiration_date: credit_card_expiration_date,
        result: result }.to_json
    end

    def self.find(id)
      result = transactions.where(:id => id.to_i).limit(1).first
      new(result) if result
    end

    def self.find_by_credit_card_number(cc)
      result = transactions.limit(1).where(credit_card_number: cc).first
      new(result) if result
    end

    def self.find_all_by_credit_card_number(cc)
      results = transactions.where(credit_card_number: cc)
      results.collect {|result| new(result)} if results
    end

    def self.find_by_invoice_id(id)
      result = transactions.limit(1).where(invoice_id: id.to_i).first
      new(result) if result
    end

    def self.find_all_by_invoice_id(id)
      results = transactions.where(invoice_id: id.to_i)
      results.collect {|result| new(result)} if results
    end

    def self.find_all_by_result(result)
      founds = transactions.where(Sequel.ilike(:result, "#{result}"))
      founds.collect {|found| new(found)} if founds
    end

    def self.random
      result = transactions.to_a.sample
      new(result) if result
    end

    def self.transactions
      Database.transactions
    end
  end
end