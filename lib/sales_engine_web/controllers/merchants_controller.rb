module SalesEngineWeb
  class MerchantsController
    def self.find(args)
      args[:id] ? merchant = Merchant.find(args[:id]) : merchant = Merchant.find_by_name(args[:name])
      Response.new({:body => merchant.to_json, :status => 200})
    end

    def self.find_all(args)
      merchants = Merchant.find_all_by_name(args[:name])
      Response.new(:body => merchants.to_json, :status => 200)
    end
  end
end