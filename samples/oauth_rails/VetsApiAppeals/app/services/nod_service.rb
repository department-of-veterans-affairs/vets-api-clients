class NodService
  include HTTParty
  base_uri "#{Figaro.env.vets_api_url}/services/appeals/v1/decision_reviews/notice_of_disagreements"

  def initialize(apikey)
    @apikey = apikey
  end

  def schema
    self.class.get '/schema', headers: { apikey: @apikey }
  end

  def header_schema
    # Taken from vets-api appeals 10182 header schema, commit d123c4de3dda49c3ac148081e1a0dadcc5171f5e
    {
      "$schema": "http://json-schema.org/draft-07/schema#",
      "description": "JSON Schema for Notice of Disagreement Creation endpoint headers (Decision Reviews API)",
      "$ref": "#/definitions/nodCreateHeadersRoot",
      "definitions": {


        "nodCreateHeadersRoot": {
          "type": "object",
          "additionalProperties": false,
          "properties": {
            "X-VA-First-Name":      { "$ref": "#/definitions/X-VA-First-Name" },
            "X-VA-Middle-Initial":  { "$ref": "#/definitions/X-VA-Middle-Initial" },
            "X-VA-Last-Name":       { "$ref": "#/definitions/X-VA-Last-Name" },
            "X-VA-SSN":             { "$ref": "#/definitions/X-VA-SSN" },
            "X-VA-File-Number":     { "$ref": "#/definitions/X-VA-File-Number" },
            "X-VA-Birth-Date":      { "$ref": "#/definitions/X-VA-Birth-Date" },
            "X-Consumer-Username":  { "$ref": "#/definitions/X-Consumer-Username"},
            "X-Consumer-ID":        { "$ref": "#/definitions/X-Consumer-ID"}
          },
          "required": [
            "X-VA-First-Name",
            "X-VA-Last-Name",
            "X-VA-SSN",
            "X-VA-Birth-Date"
          ]
        },

        "X-VA-SSN": {
          "allOf": [
            { "description": "social security number" },
            { "type": "string", "minLength": 0, "maxLength": 9, "pattern": "^[0-9]{9}$" }
          ]
        },

        "X-VA-First-Name": {
          "allOf": [
            { "description": "first name" },
            {
              "type": "string",
              "$comment": "can be whitespace, to accommodate those with 1 legal name"
            }
          ]
        },

        "X-VA-Middle-Initial": {
          "allOf": [
            { "description": "middle initial" },
            { "$ref": "#/definitions/nodCreateHeadersNonBlankString" }
          ]
        },

        "X-VA-Last-Name": {
          "allOf": [
            { "description": "last name" },
            { "$ref": "#/definitions/nodCreateHeadersNonBlankString" }
          ]
        },

        "X-VA-Birth-Date": {
          "allOf": [
            { "description": "birth date" },
            { "minLength": 10 },
            { "maxLength": 10 },
            { "$ref": "#/definitions/nodCreateHeadersDate" }
          ]
        },

        "X-VA-File-Number": {
          "allOf": [
            { "description": "VA file number (c-file / css)" },
            { "maxLength": 9 },
            { "$ref": "#/definitions/nodCreateHeadersNonBlankString" }
          ]
        },

        "X-Consumer-Username": {
          "allOf": [
            { "description": "Consumer Username (passed from Kong)" },
            { "$ref": "#/definitions/nodCreateHeadersNonBlankString" }
          ]
        },

        "X-Consumer-ID": {
          "allOf": [
            { "description": "Consumer GUID" },
            { "$ref": "#/definitions/nodCreateHeadersNonBlankString" }
          ]
        },

        "nodCreateHeadersDate": { "type": "string", "pattern": "^[0-9]{4}(-[0-9]{2}){2}$" },

        "nodCreateHeadersNonBlankString": {
          "type": "string",
          "pattern": "[^ \\f\\n\\r\\t\\v\\u00a0\\u1680\\u2000-\\u200a\\u2028\\u2029\\u202f\\u205f\\u3000\\ufeff]",
          "$comment": "The pattern used ensures that a string has at least one non-whitespace character. The pattern comes from JavaScript's \\s character class. \"\\s Matches a single white space character, including space, tab, form feed, line feed, and other Unicode spaces. Equivalent to [ \\f\\n\\r\\t\\v\\u00a0\\u1680\\u2000-\\u200a\\u2028\\u2029\\u202f\\u205f\\u3000\\ufeff].\": https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions/Character_Classes  We are using simple character classes at JSON Schema's recommendation: https://tools.ietf.org/html/draft-handrews-json-schema-validation-01#section-4.3"
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
    params.slice('data', 'included').to_json
  end

  def build_headers(params = {})
    {}.tap do |h|
      h['apikey'] = params['apikey']
      params.fetch('nodCreateHeadersRoot', {}).each do |header, value|
        h[header] = value
      end
    end
  end
end
