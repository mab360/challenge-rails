require 'spec_helper' 

describe Offer do
	it "should crawl and create offer" do
		Offer.crawl(10)
		offers = Offer.all
    offers.should have(10).entries
	end

	it "should crawl multiple times and not create duplicate offers" do 
		10.times do
			Offer.crawl(10)
		end
		distinct_offers = Offer.select("DISTINCT id").count
		total_offers = Offer.count
		distinct_offers.should eql(total_offers)
	end

end