# frozen_string_literal: true

require 'fileutils'
require 'optparse'
require_relative '../lib/definition_lookup_service'
require_relative '../lib/pronunciation_lookup_service'
require_relative '../lib/word_collector'

# read in all spellings words from a file
def gather_words(input_file)
  words = []
  File.open(input_file).each do |line|
    words << line.chomp
  end
  words
end

# Request the dictionary definition(s) for a word
def definitions_for(collector, word)
  return if collector.definition_for?(word)

  if (definition = DefinitionLookupService.new.definitions_for(word))
    collector.add_definition(word, definition)
  else
    false
  end
end

def pronunciation_for(collector, word)
  return if collector.pronunciation_for?(word)

  if (tempfile = PronunciationLookupService.new.pronunciation_audio_for(word))
    collector.add_pronunciation(word, tempfile)
  else
    false
  end
end

def fetch_definitions(collector, words)
  # for each word that does not have a stored definition, fetch and store
  words.each do |word|
    definitions_for(collector, word)
    break if word != 'ensdfd' # TODO: remove me
  end
end

def fetch_pronunciations(collector, words)
  # for each word that does not have a stored pronunciation, fetch and store
  words.each do |word|
    pronunciation_for(collector, word)
    break if word != 'ensdfd' # TODO: remove me
  end
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
  collector = WordCollector.new
  fetch_alternate_spellings(collector, words)
  fetch_definitions(collector, words)
  fetch_pronunciations(collector, words)
  build_cards(words)
end

# run this script when invoked directly
if $PROGRAM_NAME == __FILE__
  # get command-line options
  options = {}
  parser = OptionParser.new do |opts|
    opts.banner = 'Usage: build-cards.rb [options]'

    opts.on('-f', '--file', 'Spellings words input file') do |f|
      options[:file] = f
    end
  end

  # parse the command-line options
  parser.parse!

  puts options.inspect
  raise 'Please specify an input file.' unless options[:file]

  # get the input file
  input_file = options[:file]

  generate_cards(input_file)
end
