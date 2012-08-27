local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local ui = require "scripts.lib.ui"
local radlib = require "scripts.lib.radlib"
require "deck"

local screenGroup = nil
local deckImage = nil
local deck = nil
local playerHand = nil
local dealerHand = nil

local drawDealerCard = nil

local initializeCardGame = function()
  deck = Deck.static:newStandardDeck()
  print("Deck was initialized with " .. #deck.cards .. " cards.")
  deck:shuffle()
  playerHand = Deck.static:newEmptyDeck()
  dealerHand = Deck.static:newEmptyDeck()
  drawDealerCard()
end

local renderDeck = function()
  local deckImage = display.newImageRect( "images/cardback.png", 75, 110 )
  deckImage.x = 50
  deckImage.y = display.contentHeight/2
  screenGroup:insert(deckImage)
end

local drawDealerCard = function()
  print("Deck has " .. #deck.cards .. " cards.")
  local card = deck:drawCard()
  dealerHand:addCard(card)
  print("Added to dealer hand: " .. card.name)
end

local drawPlayerCard = function()
end

local drawDealerCards = function()
  drawDealerCard()
end

local drawPlayerCards = function()
  playerHand:addCard(deck:drawCard())
  playerHand:addCard(deck:drawCard())
end

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
function scene:createScene( event )
  screenGroup = self.view
end

function scene:enterScene( event )
  print("Playing the card game with " .. storyboard.state.bet .. " bet")

  initializeCardGame()
  renderDeck()
  drawDealerCards()
  drawPlayerCards()

  storyboard.removeAll()
end

function scene:exitScene( event )
end

function scene:destroyScene( event )
end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
--
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )
---------------------------------------------------------------------------------

return scene


