require 'rails_helper'

RSpec.describe "SelectYears", type: :request do
  describe "GET /edit" do
    it "returns http success" do
      get "/select_year/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
