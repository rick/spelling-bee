# frozen_string_literal: true

require 'dotenv/load'

# read in all spellings words from a file
def gather_words(input_file)
  words = []
  File.open(input_file).each do |line|
    words << line.chomp
  end
  words
end

def fetch_alternate_spellings
  # load JSON file of alternative spellings
  # TODO: make a reasonable location for this file
  # TODO: bring alternative spellings into the hash
  # JSON.parse(File.read("path/alternative-spellings.json"))
end

def fetch_definitions(words)
  # TODO: for each word that does not have a stored definition, fetch and store
end

def fetch_pronunciations(words)
  # TODO: for each word that does not have a stored pronunciation, fetch and store
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
