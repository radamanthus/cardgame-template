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
local deckImage = nil
local playerCardImages = {}
local dealerCardImages = {}

local dealerScore = 0
local playerScore = 0

local shuffle = function(cards)
  local deckSize = #cards
  for i = 1, deckSize do
    local swapWith = math.random(deckSize)
    cards[i], cards[swapWith] = cards[swapWith], cards[i]
  end
end

local SUITS = {'club', 'diamond', 'heart', 'spade'}
local getStandardDeck = function()
  local standardDeck = {}
  for i = 1,13 do
    for j = 1,4 do
      local imageFile = "images/" .. SUITS[j] .. i .. ".png"
      local card = {
        number = i,
        suit = SUITS[j],
        image = imageFile
      }
      table.insert(standardDeck, card)
    end
  end
  return standardDeck
end

local initializeCardGame = function()
  deck = getStandardDeck()
  shuffle(deck)
  playerHand = {}
  dealerHand = {}
end

local renderDeck = function()
  deckImage = display.newImageRect( "images/cardback.png", 75, 110 )
  deckImage.x = 50
  deckImage.y = display.contentHeight/2
  screenGroup:insert(deckImage)
end

local drawDealerCard = function(faceDown)
  local card = deck[#deck]
  table.insert(dealerHand, card)
  table.remove(deck)
  local cardImage = nil
  if (faceDown == true) then
    cardImage = display.newImageRect( "images/cardback.png", 75, 110 )
  else
    cardImage = display.newImageRect( card.image, 75, 110 )
  end
  cardImage.x = deckImage.x
  cardImage.y = deckImage.y
  table.insert(dealerCardImages, cardImage)
  screenGroup:insert(cardImage)
  local targetX = 180 + (25 * #dealerCardImages)
  local targetY = 70
  transition.to(cardImage, {x=targetX, y=targetY, time=500})
end

local drawPlayerCard = function()
  local card = deck[#deck]
  table.insert(playerHand, card)
  table.remove(deck)
  local cardImage = display.newImageRect( card.image, 75, 110 )
  cardImage.x = deckImage.x
  cardImage.y = deckImage.y
  table.insert(playerCardImages, cardImage)
  screenGroup:insert(cardImage)
  local targetX = 180 + (25 * #playerCardImages)
  local targetY = 270
  transition.to(cardImage, {x=targetX, y=targetY, time=500})
end

local drawDealerCards = function()
  drawDealerCard(true)
  timer.performWithDelay(500, drawDealerCard, 1)
end

local drawPlayerCards = function()
  drawPlayerCard()
  timer.performWithDelay(500, drawPlayerCard, 1)
end

local checkForDealerBlackJack = function()
  dealerScore = 0
  for i,card in ipairs(dealerHand) do
    dealerScore = dealerScore + card.number
  end
end

local onHitButtonPressed = function(event)
  if event.phase == "ended" and event.target.isActive then
  end
end

local onStayButtonPressed = function(event)
  if event.phase == "ended" and event.target.isActive then
  end
end

local renderHitOrStayButtons = function()
  hitButton = ui.newButton(
    radlib.table.merge(
      _G.buttons['hit'],
      { onRelease = onHitButtonPressed }
    )
  )
  hitButton.x = 360
  hitButton.y = 220
  hitButton.bet = 10
  hitButton.isActive = false
  screenGroup:insert(hitButton)

  stayButton = ui.newButton(
    radlib.table.merge(
      _G.buttons['stay'],
      { onRelease = onStayButtonPressed }
    )
  )
  stayButton.x = 360
  stayButton.y = 280
  stayButton.bet = 10
  stayButton.isActive = false
  screenGroup:insert(stayButton)
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
  timer.performWithDelay(1000, drawPlayerCards, 1)

  checkForDealerBlackJack()
  renderHitOrStayButtons()
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


