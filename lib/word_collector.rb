# frozen_string_literal: true

# Manage collection and storage of words, definitions, and pronunciations
class WordCollector
  attr_reader :words

  def initialize
    @words = {}
  end

  def audio_base_path
    File.join(File.dirname(__FILE__), '..', 'audio')
  end

  def audio_path(word)
    File.join(audio_base_path, "#{word.downcase}.mp3")
  end

  def definition_for?(word)
    words[word] && words[word][:definition]
  end

  def pronunciation_for?(word)
    # TODO: check for the existence of the audio file; load on request
    words[word] && words[word][:pronunciation]
  end

  # TODO: probably need a pronunciation(word) method that also loads the audio file
  # TODO: probably need a definitions(word) method that also loads the definition data

  def add_word(word)
    words[word] ||= {}
  end

  def add_definition(word, definition)
    words[word][:definition] = definition
  end

  def add_pronunciation(word, tempfile)
    words[word][:pronunciation] = tempfile
    store_pronunciation(word, tempfile)
  end

  def store_pronunciation(word, tempfile)
    tempfile.close
    FileUtils.cp(tempfile.path, audio_path(word))
  ensure
    tempfile.unlink
  end
end
