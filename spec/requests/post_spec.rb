require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /index" do
    context "when given no query nor pagination" do
      it "returns http success" do
        get "/posts"
        expect(response).to have_http_status(:success)
      end
    end

    context "when given a query" do
      it "returns http success"
      it "returns posts matching the query" # TODO: to be done simply counting the number of posts assigned
    end

    context "when given a pagination" do
      it "returns http success"
      it "returns the correct collection of posts"
    end
  end

  # Note: Happy to discuss how I would set theses specs.
  # bascially dealing with params and having a good organisation of my let and let! along with FactoryBot correctly set up.
end
