--Heaven's Lost Property
function c511000554.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000554.target)
	e1:SetOperation(c511000554.activate)
	c:RegisterEffect(e1)
end
function c511000554.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,3) and Duel.IsPlayerCanDraw(1-tp,3) end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,PLAYER_ALL,2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,PLAYER_ALL,3)
end
function c511000554.activate(e,tp,eg,ep,ev,re,r,rp)
	local h1=Duel.Draw(tp,3,REASON_EFFECT)
	local h2=Duel.Draw(1-tp,3,REASON_EFFECT)
	if h1>0 or h2>0 then Duel.BreakEffect() end
	if h1>0 then
		Duel.ShuffleHand(tp)
		Duel.DiscardHand(tp,aux.TRUE,2,2,REASON_EFFECT+REASON_DISCARD)
	end
	if h2>0 then 
		Duel.ShuffleHand(1-tp)
		Duel.DiscardHand(1-tp,aux.TRUE,2,2,REASON_EFFECT+REASON_DISCARD)
	end
end
