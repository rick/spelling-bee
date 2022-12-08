# frozen_string_literal: true

require 'cgi'
require 'dotenv/load'
require 'down'
require 'http'

# Wrap Google static pronuncation files endpoint, providing a simple interface for fetching word pronunciations
class PronunciationLookupService
  attr_reader :url

  def initialize
    @url = 'https://ssl.gstatic.com/dictionary/static/sounds/oxford/%%%WORD%%%--_us_1.mp3'
  end

  def pronunciation_audio_for(word)
    full_url = url.gsub('%%%WORD%%%', CGI.escape(word))
    Down.download(full_url)
  rescue Down::Error => e
    warn "Failed to download pronunciation for #{word}: #{e}"
    false
  end
end
