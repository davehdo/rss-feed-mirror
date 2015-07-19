class Feed < ActiveRecord::Base
    require "net/http"
    require "uri"

    validates_presence_of :name
    # validates_presence_of :original_url
    validates_uniqueness_of :name
    self.primary_key = "name"

    before_save :parameterize_name
    
    def parameterize_name
        self.name = self.name.parameterize if self.name.present?
    end
    
    def to_param
        self.name || self.id    
    end
    
    def push

        if self.push_url.present?
            begin
                uri = URI.parse( self.push_url )
        
                http = Net::HTTP.new(uri.host, uri.port)
                http.use_ssl = (uri.scheme == "https")
                request = Net::HTTP::Post.new(uri.request_uri)
                request.set_form_data({feed: {last_body: "My query #{Time.now}"}})
                
                response = http.request(request)
                
                self.pushed_at = Time.now if response.status == 200
                [true, :success]
            rescue
                # tried to push but failed
                [false, :tried_to_push_but_failed]
            end
        else
            puts "no push_url"
            [false, :no_push_url_defined]
        end
    end
    
    def fetch

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
