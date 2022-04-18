require "rails_helper"

RSpec.describe HlrService do
  it "#schema" do
    VCR.use_cassette("hlr_schema") do
      subject = described_class.new("SECRET_API_KEY_HERE")
      response = JSON.parse(subject.schema.body)
      expect(response).to have_key("$schema")
      expect(response).to have_key("description")
      expect(response).to have_key("$ref")
      expect(response).to have_key("definitions")
    end
  end

  it "#header_schema" do
    subject = described_class.new("SECRET_API_KEY_HERE")
    response = JSON.parse(subject.header_schema)
    expect(response).to have_key("$schema")
    expect(response).to have_key("description")
    expect(response).to have_key("$ref")
    expect(response).to have_key("definitions")
  end

  it "#post" do
    VCR.use_cassette("hlr_post") do
      subject = described_class.new("SECRET_API_KEY_HERE")
      params = JSON.parse(File.read("#{Rails.root}/spec/fixtures/valid_200996_minimum.json"))
      response = subject.post(params)
      expect(response).to have_key("attributes")
      expect(response).to have_key("id")
      expect(response["type"]).to eq("higherLevelReview")
    end
  end

  it "#get" do
    VCR.use_cassette("hlr_get") do
      subject = described_class.new("SECRET_API_KEY_HERE")
      response = subject.get("95aa02ff-01f7-4d4e-8ab8-73bd1cc51c56")
      expect(response).to have_key("attributes")
      expect(response["attributes"]["status"]).to eq("submitted")
      expect(response).to have_key("id")
      expect(response["type"]).to eq("higherLevelReview")
    end
  end
end
