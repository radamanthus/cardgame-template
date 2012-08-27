local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local ui = require "scripts.lib.ui"
local radlib = require "scripts.lib.radlib"

local bet10Button = nil
local bet25Button = nil
local bet50Button = nil
local screenGroup = nil

local function onBetButtonPressed ( event )
  if event.phase == "ended" and event.target.isActive then
    storyboard.state.bet = event.target.bet
    storyboard.gotoScene( "card_game_scene" )
  end
end

local renderBetButtons = function()
  bet10Button = ui.newButton(
    radlib.table.merge(
      _G.buttons['bet10'],
      { onRelease = onBetButtonPressed }
    )
  )
  bet10Button.x = 160
  bet10Button.y = 80
  bet10Button.bet = 10
  bet10Button.isActive = true
  screenGroup:insert(bet10Button)

  bet25Button = ui.newButton(
    radlib.table.merge(
      _G.buttons['bet25'],
      { onRelease = onBetButtonPressed }
    )
  )
  bet25Button.x = 160
  bet25Button.y = 150
  bet25Button.bet = 25
  bet25Button.isActive = true
  screenGroup:insert(bet25Button)

  bet50Button = ui.newButton(
    radlib.table.merge(
      _G.buttons['bet50'],
      { onRelease = onBetButtonPressed }
    )
  )
  bet50Button.x = 160
  bet50Button.y = 220
  bet50Button.bet = 50
  bet50Button.isActive = true
  screenGroup:insert(bet50Button)
end
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
function scene:createScene( event )
  screenGroup = self.view

  renderBetButtons()
end

function scene:enterScene( event )
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

