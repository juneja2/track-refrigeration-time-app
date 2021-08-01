require 'rails_helper'

RSpec.describe "UpdateOutTimes", type: :request do
  describe "GET /update_out_times" do
    it "works! (now write some real specs)" do
      post update_out_time_path
      expect(response).to have_http_status(200)
    end
  end
end
