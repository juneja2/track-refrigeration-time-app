require 'rails_helper'

RSpec.describe "refrigeration times", type: :request do  
  fixtures :locations

  context "when cache_table is empty" do
    describe "get out time for any item(existent or non-existent)" do
      it "should be 0 seconds outside refrigerator" do
        get get_out_time_path, params: { item_id: 0 }
        expect(response).to have_http_status(200)
        expect(response.body).to include("Item Id: 0")
        expect(response.body).to include("0 seconds")
        
        get get_out_time_path, params: { item_id: 10 }
        expect(response).to have_http_status(200)
        expect(response.body).to include("Item Id: 10")
        expect(response.body).to include("0 seconds")
       end
    end
  end

  context "when cache_table gets filled" do
    describe "get out time when moving between different refrigerators" do
      it "should be 0 seconds outside refrigerator" do
        post update_out_time_path, params: { item_id: 2, location_id: 0, timestamp: 5 }

        expect(response).to redirect_to get_out_time_path(item_id: 2)
        follow_redirect!
        expect(response.body).to include("Item Id: 2")
        # post update_out_time_path, params: { item_id: 2, location_id: 1, timestamp: 120 }
        # post update_out_time_path, params: { item_id: 2, location_id: 2, timestamp: 200 }
        # post update_out_time_path, params: { item_id: 2, location_id: 3, timestamp: 2412 }
      end
    end
  end
end
