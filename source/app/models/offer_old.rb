class Offer < ActiveRecord::Base
  belongs_to :merchant  

  def self.crawl
    developer_key = '00853007dc51e2bd4d3d139cbd8d387b1c3d9cae8afd4cef2a8c5add85d2808d34cf17e3303197fc22fbbd5ec4467b40c244f99035561789932878bdcf14ef7b67/1faecb4fe7d2ce415f7418e7267ef71a42b5d0f7934607e6d1389455cf3b715b70892b0ec2da8136c8bff4ab91ebcfec466caf8eacfd7d16a4ffe42e935cc0a1'
    website_id = '5742006'

    cj = CommissionJunction.new(developer_key, website_id)
    response = cj.link_search('records-per-page' => '2')

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