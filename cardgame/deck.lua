require 'scripts.lib.middleclass'
local radlib = require 'scripts.lib.radlib'

Deck = class('Deck')

------------------------------------------------------------------------------
-- CLASS (STATIC) METHODS - START
------------------------------------------------------------------------------
function Deck:initialize(params)
  for k,v in pairs(params) do
    self[k] = v
  end
  return self
end

------------------------------------------------------------------------------
-- Initialize a deck from a json file
------------------------------------------------------------------------------
function Deck.static:initializeFromJson(filename)
  local deck_file = system.pathForFile( filename, system.ResourceDirectory )
  local deck = radlib.io.parseJson(deck_file)
  return Deck:initialize(deck)
end

------------------------------------------------------------------------------
-- Initialize a standard deck
------------------------------------------------------------------------------
function Deck.static:newStandardDeck()
  return Deck.static:initializeFromJson("data/standard_cards.json")
end

------------------------------------------------------------------------------
-- Initialize an empty deck
------------------------------------------------------------------------------
function Deck.static:newEmptyDeck()
  return Deck.static:initialize({cards={}})
end
------------------------------------------------------------------------------
-- CLASS (STATIC) METHODS - END
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- INSTANCE METHODS - START
------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Adds the given card to the top of the deck
------------------------------------------------------------------------------
function Deck:addCard(card)
  table.insert(self.cards, card)
end

------------------------------------------------------------------------------
-- Removes the card at the top of the deck, and returns it
------------------------------------------------------------------------------
function Deck:drawCard()
  local lastCardIndex = #self.cards
  print("Last card index: " .. lastCardIndex)
  local result = self.cards[lastCardIndex]
  table.remove(self.cards)
  return result
end


------------------------------------------------------------------------------
-- Shuffles the cards using the Knuth shuffle
------------------------------------------------------------------------------
function Deck:shuffle()
  local deckSize = #self.cards
  for i = 1, deckSize do
    local swapWith = math.random(deckSize)
    self.cards[i], self.cards[swapWith] = self.cards[swapWith], self.cards[i]
  end
end

------------------------------------------------------------------------------
-- INSTANCE METHODS - END
------------------------------------------------------------------------------
