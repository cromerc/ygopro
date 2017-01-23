--Spellbook Inside the Pot
function c511000506.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000506.target)
	e1:SetOperation(c511000506.activate)
	c:RegisterEffect(e1)
end
function c511000506.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) and Duel.IsPlayerCanDraw(1-tp,3) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,3)
end
function c511000506.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(tp,3,REASON_EFFECT)
	Duel.Draw(1-tp,3,REASON_EFFECT)
end
