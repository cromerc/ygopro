--Action Card - Quiz - 5000 of Mathematics
function c95000093.initial_effect(c)
	--Activate/Answer
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COIN+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95000093.target)
	e1:SetOperation(c95000093.activate)
	c:RegisterEffect(e1)
end
function c95000093.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c95000093.activate(e,tp,eg,ep,ev,re,r,rp)
	local coin=Duel.SelectOption(tp,60,61)
	local res=Duel.TossCoin(tp,1)
	if coin~=res then
	Duel.Recover(tp,5000,REASON_EFFECT)
	else
	Duel.Damage(tp,5000,REASON_EFFECT)
	end
end