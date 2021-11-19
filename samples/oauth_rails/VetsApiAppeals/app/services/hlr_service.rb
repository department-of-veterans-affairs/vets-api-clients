class HlrService
  include HTTParty
  base_uri "#{Figaro.env.vets_api_url}/services/appeals/v2/decision_reviews/higher_level_reviews"

  def initialize(apikey)
    @apikey = apikey
  end

  def schema
    self.class.get '/schema', headers: { apikey: @apikey }
  end

  def header_schema
    # Taken from vets-api appeals 200996 header schema, commit d6a57d2046248013e52a38fc490c1cd6e5cb955c
    {
      "$schema": "http://json-schema.org/draft-07/schema#",
      "description": "JSON Schema for Higher-Level Review Creation endpoint headers (Decision Reviews API)",
      "$ref": "#/definitions/hlrCreateParameters",
      "definitions": {
        "nonBlankString": {
          "type": "string",
          "pattern": "[^ \\f\\n\\r\\t\\v\\u00a0\\u1680\\u2000-\\u200a\\u2028\\u2029\\u202f\\u205f\\u3000\\ufeff]",
          "$comment": "The pattern used ensures that a string has at least one non-whitespace character. The pattern comes from JavaScript's \\s character class. \"\\s Matches a single white space character, including space, tab, form feed, line feed, and other Unicode spaces. Equivalent to [ \\f\\n\\r\\t\\v\\u00a0\\u1680\\u2000-\\u200a\\u2028\\u2029\\u202f\\u205f\\u3000\\ufeff].\": https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions/Character_Classes  We are using simple character classes at JSON Schema's recommendation: https://tools.ietf.org/html/draft-handrews-json-schema-validation-01#section-4.3"
        },

        "date": { "type": "string", "pattern": "^[0-9]{4}(-[0-9]{2}){2}$" },

        "hlrCreateParameters": {
          "type": "object",
          "properties": {
            "X-VA-SSN": {
              "type": "string",
              "description": "Veteran's SSN",
              "pattern": "^[0-9]{9}$"
            },
            "X-VA-First-Name": {
              "type": "string",
              "description": "Veteran's first name",
              "maxLength": 30,
              "$comment": "can be whitespace, to accommodate those with 1 legal name"
            },
            "X-VA-Middle-Initial": {
              "allOf": [
                { "description": "Veteran's middle initial", "maxLength": 1 },
                { "$ref": "#/definitions/nonBlankString" }
              ]
            },
            "X-VA-Last-Name": { "allOf": [
              { "description": "Veteran's last name", "maxLength": 40 },
              { "$ref": "#/definitions/nonBlankString" }
            ] },
            "X-VA-Birth-Date": { "allOf": [
              { "description": "Veteran's birth date" },
              { "$ref": "#/definitions/date" }
            ] },
            "X-VA-File-Number": { "allOf": [
              { "description": "Veteran's file number", "maxLength":  9 },
              { "$ref": "#/definitions/nonBlankString" }
            ] },
            "X-VA-Insurance-Policy-Number": { "allOf": [
              { "description": "Veteran's insurance policy number", "maxLength": 18 },
              { "$ref": "#/definitions/nonBlankString" }
            ] },
            "X-Consumer-Username": {
              "allOf": [
                { "description": "Consumer User Name (passed from Kong)" },
                { "$ref": "#/definitions/nonBlankString" }
              ]
            },
            "X-Consumer-ID": { "allOf": [
              { "description": "Consumer GUID" },
              { "$ref": "#/definitions/nonBlankString" }
            ] }
          },
          "additionalProperties": false,
          "required": [
            "X-VA-SSN",
            "X-VA-First-Name",
            "X-VA-Last-Name",
            "X-VA-Birth-Date"
          ]
        }
      }
    }.to_json
  end

  def post(params)
    get_data(self.class.post('/', body: build_body(params), headers: build_headers(params)))
  end

  def get(guid)
    get_data(self.class.get("/#{guid}", headers: { apikey: @apikey }))
  end

  private

  def get_data(response)
    JSON.parse(response&.body)['data']
  end

  def build_body(params = {})
    # Assume that a missing informalConferenceType is false
    params['data']['attributes']['informalConference'] = params['data']['attributes']['informalConference'].presence || false
    params.slice('data', 'included').to_json
  end

  def build_headers(params = {})
    {}.tap do |h|
      h['apikey'] = params['apikey']
      params.fetch('hlrCreateParameters', {}).each do |header, value|
        h[header] = value
      end
    end
  end
end
