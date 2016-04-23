--Blasting Vein
function c170000119.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c170000119.target)
	e1:SetOperation(c170000119.activate)
	c:RegisterEffect(e1)
end
function c170000119.filter(c)
	return c:IsFacedown() and c:IsDestructable() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c170000119.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c170000119.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c170000119.filter,tp,LOCATION_SZONE,0,1,e:GetHandler()) 
	and Duel.IsPlayerCanDraw(tp,2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c170000119.filter,tp,LOCATION_SZONE,0,1,1,e:GetHandler())
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c170000119.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
	Duel.Destroy(tc,REASON_EFFECT)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	end
end