# spelling-bee training tools

This will probably just generate Anki cards with pronunciations and definitions on the front, with 
the spelled word on the back.

### rough TODO

 - [x] find a way to get pronunciations
 - [x] find an API for word definition lookups
 - [x] look up word definitions
 - [x] find a ruby lib to generate anki cards (https://github.com/rkachowski/anki-rb)
 - [ ] upgrade dictionary API key to use the highest level dictionary available from MW (currently too low level for all words)
 - [ ] roll a ruby script that automates populating data and cards
   - [ ] for each word pull definitions, handle errors properly (i.e., detect them, also make an exceptions log); be idempotent
   - [ ] ... pull pronunciations (similarly, with the error handling), also be idempotent
   - [ ] generate Anki cards with audio file linkage, definitions (front) and correct spelling (back)
   - [ ] handle alternate spellings (probably an alternates hash in a JSON doc or something; add alternates to card backs
 - [ ] document getting API key, setting in ENV (probably use a different name); or maybe go full `dotenv`
