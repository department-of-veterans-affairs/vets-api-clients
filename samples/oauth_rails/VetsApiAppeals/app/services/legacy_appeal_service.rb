class LegacyAppealService
  include HTTParty
  base_uri "#{Figaro.env.vets_api_url}/services/appeals/v2/decision_reviews/legacy_appeals"

  def initialize(apikey)
    @apikey = apikey
  end

  def schema
    {}.to_json
  end

  def header_schema
    # Taken from modules/appeals_api/config/schemas/v2/legacy_appeals_headers.json, commit 2c7c27af7f8b2c80b97d78fb8e8a443fe2507e0f
    {
      "$schema": "http://json-schema.org/draft-07/schema#",
      "description": "JSON Schema for Legacy Appeals endpoint headers (Decision Reviews API)",
      "$ref": "#/definitions/legacyAppealsIndexParameters",
      "definitions": {
        "nonBlankString": {
          "type": "string",
          "pattern": "[^ \\f\\n\\r\\t\\v\\u00a0\\u1680\\u2000-\\u200a\\u2028\\u2029\\u202f\\u205f\\u3000\\ufeff]",
          "$comment": "The pattern used ensures that a string has at least one non-whitespace character. The pattern comes from JavaScript's \\s character class. \"\\s Matches a single white space character, including space, tab, form feed, line feed, and other Unicode spaces. Equivalent to [ \\f\\n\\r\\t\\v\\u00a0\\u1680\\u2000-\\u200a\\u2028\\u2029\\u202f\\u205f\\u3000\\ufeff].\": https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions/Character_Classes  We are using simple character classes at JSON Schema's recommendation: https://tools.ietf.org/html/draft-handrews-json-schema-validation-01#section-4.3"
        },

        "legacyAppealsIndexParameters": {
          "type": "object",
          "properties": {
            "X-VA-SSN": {
              "type": "string",
              "description": "Veteran's SSN",
              "pattern": "^[0-9]{9}$",
              "minLength": 9,
              "maxLength": 9
            },
            "X-VA-File-Number": {
              "allOf": [
                { "$ref": "#/definitions/nonBlankString" },
                { "description": "Veteran's file number", "minLength": 1, "maxLength": 9 }
              ]
            }
          },
          "oneOf": [
            { "required": ["X-VA-SSN"] },
            { "required": ["X-VA-File-Number"] }
          ]
        }
      }
    }.to_json
  end

  def get(params)
    get_data(self.class.get('/', headers: build_headers(params)))
  end

  private

  def get_data(response)
    JSON.parse(response&.body)['data']
  end

  def build_headers(params = {})
    {}.tap do |h|
      h['apikey'] = params['apikey']
      params.fetch('legacy_appeal', {}).each do |header, value|
        h[header] = value
      end
    end
  end
end
