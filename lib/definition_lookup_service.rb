# frozen_string_literal: true

require 'cgi'
require 'dotenv/load'
require 'http'

# Wrap M-W Dictionary API, providing a simple interface for fetching word definitions
class DefinitionLookupService
  attr_reader :key, :url

  def initialize
    @url = 'https://dictionaryapi.com/api/v3/references/collegiate/json/'
    @key = ENV.fetch('DICTIONARY_API_KEY')
    raise 'Please set the DICTIONARY_API_KEY environment variable.' unless key
  end

  def parse_response(json)
    data = JSON.parse(json)
    data.first['shortdef']
  end

  def definitions_for(word)
    response = HTTP.get(url + CGI.escape(word), params => { key: key })
    return false unless response.status.success?

    parse_response(response.body)
  end
end
