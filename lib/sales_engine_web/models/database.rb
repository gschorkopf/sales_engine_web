module SalesEngineWeb
  class Database

    def self.database
      @database ||= Sequel.sqlite("./db/sales_engine_web_#{ environment }.sqlite3")
    end

    def self.environment=(input)
      @environment = input
    end

    def self.environment
      @environment ||= :development
    end

    def self.merchants
      database[:merchants]
    end

    def self.customers
      database[:customers]
    end
    
    def self.transactions
      database[:transactions]
    end
    
    def self.items
      database[:items]
    end
    
    def self.invoices
      database[:invoices]
    end
    
    def self.invoice_items
      database[:invoice_items]
    end
  end
end