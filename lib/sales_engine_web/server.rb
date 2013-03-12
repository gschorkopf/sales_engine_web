module SalesEngineWeb
  class Server < Sinatra::Base
    get '/' do
      "Hello world"
    end

    get '/merchants/find' do
      status 200
      if params[:id]
        merchant = Merchant.find(params[:id])
      else
        merchant = Merchant.find_by_name(params[:name])
      end
      body merchant.to_json
    end

    get '/merchants/find_all' do
      status 200
      merchants = Merchant.find_all_by_name(params[:name])
      body merchants.to_json
    end

    get '/merchants/random' do
      Merchant.random.to_json
    end

    get '/invoices/find' do
      status 200
      Invoice.find(params[:id])
    end

    get '/invoices/random' do
      Invoice.random.to_json
    end
  end
end