class Offer < ActiveRecord::Base
  belongs_to :merchant
  validates :merchant, presence: true
  
  def self.crawl(records=20)
    cj = CommissionJunction.new(DEVELOPER_KEY, WEBSITE_ID)
    response = cj.link_search('records-per-page' => records)
    
    response.each do |link|      
      Merchant.find_or_create_by(:id=>link.advertiser_id) do |obj|
        obj.name = link.advertiser_name
      end

      Offer.find_or_create_by(:id=>link.link_id) do |obj|
        obj.merchant_id = link.advertiser_id
        obj.title = link.link_name
        obj.description = link.description
        obj.url = link.destination
        obj.expires_at = link.promotion_end_date        
      end
    end
  end

end