require 'spec_helper'

describe "Offers" do 
	describe "Crawl Offers" do 
		it "Crawls new offers displays the results, reloads and checks the results again" do 
			visit offers_path 
			click_button "Crawl!" 
			page.should have_content "Get Deal" 

			visit(current_path)
			page.should have_content "Get Deal"
		end 
	end 
end