class Feed < ActiveRecord::Base
    validates_presence_of :name
    validates_presence_of :original_url
    
    def fetch
        require 'net/http'

        url = URI.parse( self.original_url )
        req = Net::HTTP::Get.new(url.to_s)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = (url.scheme == "https")
        response = http.request(req)

        self.last_body = response.body
        
        self.last_pulled_at = Time.now
    end
    
end
