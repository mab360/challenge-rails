class OffersController < ApplicationController  

  def index
    @offers = Offer.all
  end

  def create
    Offer.crawl

    respond_to do |format|      
      format.html { redirect_to action: 'index' }
    end
  end
  
end