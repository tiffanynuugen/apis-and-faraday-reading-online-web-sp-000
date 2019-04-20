class SearchesController < ApplicationController

  def search
  end

  def foursquare
    begin
      @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
          req.params['client_id'] = 'KKOIM4JNEIOBSNX3IWT43UEN53PKLXHVBGD5X5CYUARZER5B'
          req.params['client_secret'] = 'OCNQGCQFGX4CFRMSN32I40FOZJDJYLYD4UXLYSAGZ0EKW5BV'
          req.params['v'] = '20160201'
          req.params['near'] = params[:zipcode]
          req.params['query'] = 'pizza'
          # req.options.timeout = 0
        end
        body = JSON.parse(@resp.body)
        if @resp.success?
          @venues = body["response"]["venues"]
        else
          @error = body["meta"]["errorDetail"]
        end

      rescue Faraday::ConnectionFailed
        @error = "There was a timeout. Please try again."
      end
      render 'search'
end
end
