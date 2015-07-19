require 'rails_helper'

RSpec.describe "feeds", :type => :request do
  it "accepts an unrecognized feed name by creating it" do
    post "/feeds/interesting", feed: {last_body: "xml-here"}

    # expect(response).to be_success
    
    expect(Feed.exists?("interesting")).to eq true
    expect(Feed.find("interesting").last_body).to eq "xml-here"
  end
  
  it "accepts a recognized feed name by updating body" do
    Feed.create(name: "interesting")
    
    post "/feeds/interesting", feed: {last_body: "xml-here"}

    # expect(response).to be_success

    expect(Feed.exists?("interesting")).to eq true
    expect(Feed.find("interesting").last_body).to eq "xml-here"

  end
end