-- A cheating AI file, which draws additional cards and recovers LP each turn


-- Configure these to your liking

require("ai.ai")

EXTRA_SUMMON = 1
EXTRA_DRAW = 1
LP_RECOVER = 1000

GlobalCheating = true

math.randomseed( require("os").time() )
function OnStartOfDuel()

  AI.Chat("AI script version "..Version)
  AI.Chat("You selected a cheating AI")
	AI.Chat("The AI will recover "..LP_RECOVER.." LP and draw "..EXTRA_DRAW.." additional cards each turn")
end
