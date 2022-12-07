# spelling-bee training tools

## Introduction

Generate [Anki](https://apps.ankiweb.net/) card decks for studying for the 2022 Scripps Spelling Bee.

The spelling bee word lists are broken out into "bee" levels ("1 bee", "2 bees", "3 bees").
For each level there is a "school study list" (i.e., basic words), and a "champion study list"
(i.e., words that winners of a local spelling bee competition should study for the next round(s)).

We have our school word lists in `words/` as `1.txt`, `2.txt`, and `3.txt` for the
respective "bee" levels. Similarly, the "champion" words are in `words` as `1-champ.txt`, etc.

## Cards

The generated Anki cards will each have:

 - **front**:
   - an audio file pronouncing the word
   - a definition (or short list of main definitions) for the word
 - **back**:
   - the spelling of the word, with alternative spellings

### Data sources

 - Our school emailed us a PDF of this year's words (as we have a bee winner in our midst)
 - We will be using the Merriam-Webster online Collegiate Dictionary API, at https://dictionaryapi.com/ to look up definitions.
 - We are downloading pronunciation `.mp3` files from Google; if this doesn't work out we may try M-W as well, or look for yet another source.

## Building your own cards

 - Clone this repo.
 - Go to https://dictionaryapi.com/ and get an API key.
 - `cp .env-example .env` and edit `.env` to put your API key in place
 - Run the generator (which will download any missing data first):

``` shell
bundle exec script/build_cards.rb -f words/1-champ.txt -o 1-champ.apkg
```
