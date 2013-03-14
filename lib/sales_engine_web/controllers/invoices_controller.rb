module SalesEngineWeb
  class InvoicesController
    def self.find(args)
      # merchant = Merchant.find(args[:id])
      # Response.new({:body => merchant.to_json})
    end

    def self.find_all(args)
      # merchants = Merchant.find_all_by_name(args[:name])
      # Response.new(:body => merchants.to_json)
    end
  end
end