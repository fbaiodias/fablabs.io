require 'rails_helper'

describe Api::V2::LabsController, :type => :request do
  default_version 2

  describe 'GET labs#index' do

    context "When authenticated"
    let!(:user) { FactoryGirl.create :user }
    let!(:lab) { FactoryGirl.create(:lab, workflow_state: 'approved', name: "Fab Lab BCN") }
    let!(:lab2) { FactoryGirl.create(:lab, name: "Fab Lab Toscana") }
    
    it "Lists labs as normal user" do
      get_as_user 'http://api.fablabs.dev/2/labs'
      # expect(json['users']).to match_array([user_helper(user)])
      
      expect(response.status).to eq(200)
      expect(response.content_type).to eq(Mime::JSON)
      
      expect(json["data"].size).to eq(1)

      @lab = json["data"][0]
      expect(@lab["type"]).to eq("lab")
      expect(@lab["attributes"]["name"]).to eq(lab.name)
      # expect(response.parsed_body).to eq({error:"Not authorized"})
    end


  end


end