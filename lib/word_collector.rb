# frozen_string_literal: true


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
