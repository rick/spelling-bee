# frozen_string_literal: true

require 'fileutils'
require 'optparse'
require_relative '../lib/definition_lookup_service'
require_relative '../lib/pronunciation_lookup_service'

# TODO: make this a class

def audio_base_path
  File.join(File.dirname(__FILE__), '..', 'audio')
end

def audio_path(word)
  File.join(audio_base_path, "#{word.downcase}.mp3")
end

def store_pronunciation(word, tempfile)
  tempfile.close
  FileUtils.cp(tempfile.path, audio_path(word))
ensure
  tempfile.unlink
end

# read in all spellings words from a file
def gather_words(input_file)
  words = []
  File.open(input_file).each do |line|
    words << line.chomp
  end
  words
end

# Request the dictionary definition(s) for a word
def definitions_for(word)
  # TODO: check if the word has a stored definition, returning that instead
  DefinitionLookupService.new.definitions_for(word)
  # TODO: store the definition(s) in the hash
  # TODO: if false, do error logging
end

def fetch_definitions(words)
  # TODO: for each word that does not have a stored definition, fetch and store
end

def fetch_pronunciations(word)
  # TODO: check if the word has a stored pronunciation, returning that instead
  tempfile = PronunciationLookupService.new.pronunciation_audio_for(word)
  # TODO: if false, do error logging
  store_pronunciation(word, tempfile)
end

def fetch_alternate_spellings
  # load JSON file of alternative spellings
  # TODO: make a reasonable location for this file
  # TODO: bring alternative spellings into the hash
  # JSON.parse(File.read("path/alternative-spellings.json"))
end

def build_cards(words)
  # TODO: iterate over words and build anki cards
end

def generate_cards(input_file)
  words = gather_words(input_file)
  fetch_alternate_spellings(words)
  fetch_definitions(words)
  fetch_pronunciations(words)
  build_cards(words)
end

# run this script when invoked directly
if $PROGRAM_NAME == __FILE__
  # get command-line options
  options = {}
  OptionParser.new do |opts|
    opts.banner = 'Usage: build-cards.rb [options]'

    opts.on('-f', '--file', 'Spellings words input file') do |f|
      options[:file] = f
    end
  end

  # get the input file
  input_file = options[:file]

  generate_cards(input_file)
end
