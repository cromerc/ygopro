--Pentacle of Ace
function c511001098.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_COIN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001098.target)
	e1:SetOperation(c511001098.activate)
	c:RegisterEffect(e1)
end
function c511001098.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) and Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c511001098.activate(e,tp,eg,ep,ev,re,r,rp)
	local res=Duel.TossCoin(tp,1)
	if res==1 then
		Duel.Draw(tp,1,REASON_EFFECT)
		Duel.Recover(tp,500,REASON_EFFECT)
	else
		Duel.Draw(1-tp,1,REASON_EFFECT)
		Duel.Recover(1-tp,500,REASON_EFFECT)
	end
end
