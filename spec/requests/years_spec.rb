require 'rails_helper'

RSpec.describe "Years", type: :request do
  describe "GET /edit" do
    it "returns http success" do
      get "/years/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
