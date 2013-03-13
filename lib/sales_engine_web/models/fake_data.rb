# module SalesEngineWeb
#     class FakeData
#         def self.start
#             let!(:customer1){ SalesEngineWeb::Customer.create(:first_name => "Geoff", :last_name => "Schorkopf") }
#             let!(:customer2){ SalesEngineWeb::Customer.create(:first_name => "Tim", :last_name => "Schorkopf") }
#             let!(:ii1){ SalesEngineWeb::InvoiceItem.create(item_id: 1, invoice_id: 1, quantity: 9, unit_price: 100) }
#             let!(:ii2){ SalesEngineWeb::InvoiceItem.create(item_id: 2, invoice_id: 1, quantity: 4, unit_price: 200) }
#             let!(:ii3){ SalesEngineWeb::InvoiceItem.create(item_id: 1, invoice_id: 2, quantity: 5, unit_price: 200) }
#             let!(:invoice1){ SalesEngineWeb::Invoice.create(:customer_id => 1, :merchant_id => 2, :status => "shipped") }
#             let!(:invoice2){ SalesEngineWeb::Invoice.create(:customer_id => 1, :merchant_id => 3, :status => "shipped") }
#             let!(:item1){ SalesEngineWeb::Item.create(name: 'Top', description: 'Spinning toy',
#                           unit_price: 7200, merchant_id: 1) }
#             let!(:item2){ SalesEngineWeb::Item.create(name: 'Game Boy', description: 'Handheld toy',
#                           unit_price: 7200, merchant_id: 1) }
#             let!(:item3){ SalesEngineWeb::Item.create(name: 'Cell phone', description: 'Communication device',
#                           unit_price: 35000, merchant_id: 1) }
#             let!(:merchant1){ SalesEngineWeb::Merchant.create(name: "Jumpstart Lab")}
#             let!(:merchant2){ SalesEngineWeb::Merchant.create(name: "gSchool")}
#             let!(:trans1){SalesEngineWeb::Transaction.create(invoice_id: 1, result: 'failed', credit_card_number: 4567) }
#             let!(:trans2){SalesEngineWeb::Transaction.create(invoice_id: 1, result: 'success', credit_card_number: 4567) }
#             let!(:trans3){SalesEngineWeb::Transaction.create(invoice_id: 2, result: 'success', credit_card_number: 1234) }
#         end
#     end
# end