class HlrService
  include HTTParty
  base_uri 'http://localhost:3000/services/appeals/v1/decision_reviews/higher_level_reviews'

  def schema
    get_data(self.class.get '/schema')
  end

  def header_schema
    # Taken from vets-api appeals 200992 header schema, commit b6c190af2
    {
      "$schema": "http://json-schema.org/draft-07/schema#",
      "description": "JSON Schema for Higher-Level Review Creation endpoint headers (Decision Reviews API)",
      "$ref": "#/definitions/hlrCreateParameters",
      "definitions": {
        "hlrCreateParameters": {
          "type": "object",
          "properties": {
            "X-VA-SSN": { "$ref": "#/definitions/X-VA-SSN" },
            "X-VA-First-Name": { "$ref": "#/definitions/X-VA-First-Name" },
            "X-VA-Middle-Initial": { "$ref": "#/definitions/X-VA-Middle-Initial" },
            "X-VA-Last-Name": { "$ref": "#/definitions/X-VA-Last-Name" },
            "X-VA-Birth-Date": { "$ref": "#/definitions/X-VA-Birth-Date" },
            "X-VA-File-Number": { "$ref": "#/definitions/X-VA-File-Number" },
            "X-VA-Service-Number": { "$ref": "#/definitions/X-VA-Service-Number" },
            "X-VA-Insurance-Policy-Number": { "$ref": "#/definitions/X-VA-Insurance-Policy-Number" },
            "X-Consumer-Username": { "$ref": "#/definitions/X-Consumer-Username" }
          },
          "additionalProperties": false,
          "required": [
            "X-VA-SSN",
            "X-VA-First-Name",
            "X-VA-Last-Name",
            "X-VA-Birth-Date"
          ]
        },
        "X-VA-SSN": {
          "allOf": [
            { "description": "veteran's SSN" },
            { "type": "string", "pattern": "^[0-9]{9}$" }
          ]
        },
        "X-VA-First-Name": {
          "allOf": [
            { "description": "veteran's first name" },
            {
              "type": "string",
              "maxLength": 12,
              "$comment": "can be whitespace, to accommodate those with 1 legal name"
            }
          ]
        },
        "X-VA-Middle-Initial": {
          "allOf": [
            { "description": "veteran's middle initial" },
            { "$ref": "#/definitions/nonBlankStringMaxLength1" }
          ]
        },
        "X-VA-Last-Name": {
          "allOf": [
            { "description": "veteran's last name" },
            { "$ref": "#/definitions/nonBlankStringMaxLength18" }
          ]
        },
        "X-VA-Birth-Date": {
          "allOf": [
            { "description": "veteran's birth date" },
            {"$ref": "#/definitions/date" }
          ]
        },
        "X-VA-File-Number": {
          "allOf": [
            { "description": "veteran's file number" },
            { "$ref": "#/definitions/nonBlankStringMaxLength9" }
          ]
        },
        "X-VA-Service-Number": {
          "allOf": [
            {"description": "veteran's service number"},
            {"$ref": "#/definitions/nonBlankStringMaxLength9"}
          ]
        },
        "X-VA-Insurance-Policy-Number": {
          "allOf": [
            { "description": "veteran's insurance policy number" },
            { "$ref": "#/definitions/nonBlankStringMaxLength18" }
          ]
        },
        "X-Consumer-Username": {
          "allOf": [
            { "description": "Consumer User Name (passed from Kong)" },
            { "$ref": "#/definitions/nonBlankString" }
          ]
        },
        "nonBlankString": {
          "type": "string",
          "pattern": "[^ \\f\\n\\r\\t\\v\\u00a0\\u1680\\u2000-\\u200a\\u2028\\u2029\\u202f\\u205f\\u3000\\ufeff]",
          "$comment": "The pattern used ensures that a string has at least one non-whitespace character. The pattern comes from JavaScript's \\s character class. \"\\s Matches a single white space character, including space, tab, form feed, line feed, and other Unicode spaces. Equivalent to [ \\f\\n\\r\\t\\v\\u00a0\\u1680\\u2000-\\u200a\\u2028\\u2029\\u202f\\u205f\\u3000\\ufeff].\": https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions/Character_Classes  We are using simple character classes at JSON Schema's recommendation: https://tools.ietf.org/html/draft-handrews-json-schema-validation-01#section-4.3"
        },
        "nonBlankStringMaxLength18": { "allOf": [ { "$ref": "#/definitions/nonBlankString" }, { "maxLength": 18 } ] },
        "nonBlankStringMaxLength9": { "allOf": [ { "$ref": "#/definitions/nonBlankString" }, { "maxLength": 9 } ] },
        "nonBlankStringMaxLength1": { "allOf": [ { "$ref": "#/definitions/nonBlankString" }, { "maxLength": 1 } ] },
        "date": { "type": "string", "pattern": "^[0-9]{4}(-[0-9]{2}){2}$" }
      }
    }.to_json
  end

  def post(params)
    get_data(self.class.post '/', body: build_body(params), headers: build_headers(params))
  end

  def get(guid)
    get_data(self.class.get "/#{guid}")
  end

  private

  def get_data(response)
    JSON.parse(response&.body)['data']
  end

  def build_body(params = {})
    body = { data: params.dig('data'), included: params.dig('included') }.with_indifferent_access

    # Convert from string to bool to adhere to schema
    body[:data][:attributes][:informalConference].yield_self { |v| v == 'true' }
    body[:data][:attributes][:sameOffice].yield_self { |v| v == 'true' }

    # Convert included from an array-like hash (e.g. { "0" => {...}, "1" => {...}, ...} ) to an array of objects
    included_params = body.delete(:included)
    body[:included] = []
    included_params.each do |_, obj|
      body[:included] << obj
    end
    body.to_json
  end

  def build_headers(params = {})
    {}.tap do |h|
      h['apikey'] = params['apikey']
      params.dig('hlrCreateParameters').each do |header, value|
        h[header] = value
      end
    end
  end
end
