Version = "0.34"
Experimental = false

--[[
  AI Script for YGOPro Percy:
  http://www.ygopro.co/

  script by Snarky
  original script by Percival18
  
  GitHub repository: 
  https://github.com/Snarkie/YGOProAIScript/
  
  Check here for updates: 
  http://www.ygopro.co/Forum/tabid/95/g/posts/t/7877/AI-Updates
  
  Contributors: ytterbite, Sebrian, Skaviory, francot514
  Optional decks: Yeon, Satone, rothayz, Ildana, Iroha, Postar, Nachk, Xaddgx
  You can find and download optional decks here:
  http://www.ygopro.co/Forum/tabid/95/g/posts/t/7877/AI-Updates
  
  for more information about the AI script, check the ai-template.lua
  
  
  
  The MIT License (MIT)

  Copyright (c) 2015 Snarky

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.

]]

GlobalCheating = false
TRASHTALK = true -- some decks might comment their actions. Set to false, if you don't like that
EXTRA_DRAW = 0
EXTRA_SUMMON = 0
LP_RECOVER = 0

PRINT_DRAW = 1 -- for debugging

function requireoptional(module)
  if not pcall(require,module) then
    --print("file missing or syntax error: "..module)
  end
end
require("ai.mod.AICheckList")
require("ai.mod.AIHelperFunctions")
require("ai.mod.AIHelperFunctions2")
require("ai.mod.AICheckPossibleST")
require("ai.mod.AIOnDeckSelect")
require("ai.mod.DeclareAttribute")
require("ai.mod.DeclareCard")
require("ai.mod.DeclareMonsterType")
require("ai.mod.SelectBattleCommand")
require("ai.mod.SelectCard")
require("ai.mod.SelectChain")
require("ai.mod.SelectEffectYesNo")
require("ai.mod.SelectInitCommand")
require("ai.mod.SelectNumber")
require("ai.mod.SelectOption")
require("ai.mod.SelectPosition")
require("ai.mod.SelectSum")
require("ai.mod.SelectTribute")
require("ai.mod.SelectYesNo")
require("ai.mod.SelectChainOrder")
require("ai.decks.Generic")
require("ai.decks.FireFist")
require("ai.decks.HeraldicBeast")
require("ai.decks.Gadget")
require("ai.decks.Bujin")
require("ai.decks.Mermail")
require("ai.decks.Shaddoll")
require("ai.decks.Satellarknight")
require("ai.decks.ChaosDragon")
require("ai.decks.HAT")
require("ai.decks.Qliphort")
require("ai.decks.NobleKnight")
require("ai.decks.Nekroz")
require("ai.decks.BurningAbyss")
require("ai.decks.DarkWorld")
require("ai.decks.Constellar")
require("ai.decks.Blackwing")
require("ai.decks.Harpie")
require("ai.decks.HERO")
require("ai.decks.ExodiaLib")
require("ai.decks.Boxer")
require("ai.decks.Monarch")
require("ai.decks.MegaMonarch")
require("ai.decks.Kozmo")
require("ai.decks.Lightsworn")
require("ai.decks.DDD")
require("ai.decks.GladBeast")
requireoptional("ai.decks.Majespecter")
requireoptional("ai.decks.Spellbook")
requireoptional("ai.decks.X-Saber")
requireoptional("ai.decks.Cth")
requireoptional("ai.decks.Wizard")
requireoptional("ai.decks.Express")


math.randomseed( require("os").time() )

function OnStartOfDuel()
  AI.Chat("AI script version "..Version)
  --if Experimental then AI.Chat("This is an experimental AI version, it might contain bugs and misplays") end
  print("start of duel")
  Startup()
end


