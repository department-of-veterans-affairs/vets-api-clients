
require "rails_helper"

RSpec.describe NodService do
  it "#schema" do
    VCR.use_cassette("nod_schema") do
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
    VCR.use_cassette("nod_post") do
      subject = described_class.new("SECRET_API_KEY_HERE")
      params = JSON.parse(File.read("#{Rails.root}/spec/fixtures/valid_10182_minimum.json"))
      response = subject.post(params)
      expect(response).to have_key("attributes")
      expect(response).to have_key("id")
      expect(response["type"]).to eq("noticeOfDisagreement")
    end
  end

  it "#get" do
    VCR.use_cassette("nod_get") do
      subject = described_class.new("SECRET_API_KEY_HERE")
      response = subject.get("773784b6-fda4-4f69-85c9-f7fb6c885809")
      expect(response).to have_key("attributes")
      expect(response["attributes"]["status"]).to eq("submitted")
      expect(response).to have_key("id")
      expect(response["type"]).to eq("noticeOfDisagreement")
    end
  end
end
