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

# Manage collection and storage of words, definitions, and pronunciations
class WordCollector
  attr_reader :words

  def initialize
    @words = {}
  end

  def definition_for?(word)
    words[word] && words[word][:definition]
  end

  def pronunciation_for?(word)
    words[word] && words[word][:pronunciation]
  end

  def add_word(word)
    words[word] ||= {}
  end

  def add_definition(word, definition)
    words[word][:definition] = definition
  end

  # TODO: ensure we add something representing the pronunciation audio
  def add_pronunciation(word, pronunciation)
    words[word][:pronunciation] = pronunciation
  end
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
  end
end

def fetch_pronunciations(collector, words)
  # for each word that does not have a stored pronunciation, fetch and store
  words.each do |word|
    pronunciation_for(collector, word)
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
  fetch_alternate_spellings(collector, words)
  fetch_definitions(collector, words)
  fetch_pronunciations(collector, words)
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
