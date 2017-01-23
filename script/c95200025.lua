--Commande duel 25
function c95200025.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_COIN+CATEGORY_RECOVER)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95200025.target)
	e1:SetOperation(c95200025.operation)
	c:RegisterEffect(e1)
end
function c95200025.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,PLAYER_ALL,1)
end
function c95200025.operation(e,tp,eg,ep,ev,re,r,rp)
	local op1=Duel.SelectYesNo(tp,aux.Stringid(95200025,0))
	local op2=Duel.SelectYesNo(1-tp,aux.Stringid(95200025,0))
	--true=wearing, false=not wearing
	local res=Duel.TossCoin(tp,1)
	local check
	if res==1 then
		check=true
	else
		check=false
	end
	if (op1 and check) or (not op1 and not check) then
		Duel.Recover(tp,800,REASON_EFFECT)
	end
	if ((op2 and check) or (not op2 and not check)) then
		Duel.Recover(1-tp,800,REASON_EFFECT)
	end
end
