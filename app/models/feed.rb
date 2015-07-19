class Feed < ActiveRecord::Base
    validates_presence_of :name
    validates_presence_of :original_url
    validates_uniqueness_of :name
    
    before_save :parameterize_name
    
    def parameterize_name
        self.name = self.name.parameterize if self.name.present?
    end
    
    def to_param
        self.name || self.id    
    end
    
    def self.find( param )
       find_by_name( param ) || find(param)
    end
    
    def fetch
        require 'net/http'

        begin
            url = URI.parse( self.original_url )
            req = Net::HTTP::Get.new(url.to_s)
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = (url.scheme == "https")
            response = http.request(req)
    
            self.last_body = response.body
            
            self.last_pulled_at = Time.now
        rescue
            # unable
        end
    end
    
end
