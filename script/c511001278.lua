--Synchro Cracker
function c511001278.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001278.target)
	e1:SetOperation(c511001278.activate)
	c:RegisterEffect(e1)
end
function c511001278.filter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsAbleToExtra()
		and Duel.IsExistingMatchingCard(c511001278.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,c:GetAttack())
end
function c511001278.desfilter(c,atk)
	return c:IsFaceup() and c:IsDestructable() and c:GetAttack()<atk
end
function c511001278.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001278.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001278.filter,tp,LOCATION_MZONE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c511001278.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
	local sg=Duel.GetMatchingGroup(c511001278.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,g:GetFirst():GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511001278.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	if Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		local sg=Duel.GetMatchingGroup(c511001278.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,tc:GetAttack())
		Duel.Destroy(sg,REASON_EFFECT)
	end
end
