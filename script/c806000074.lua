--ゴーストリック・パニック
function c806000074.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c806000074.target)
	e1:SetOperation(c806000074.activate)
	c:RegisterEffect(e1)
end
function c806000074.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet()
end
function c806000074.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c806000074.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFacedown,tp,LOCATION_MZONE,0,1,nil)
	and	Duel.IsExistingTarget(c806000074.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local ct=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_MZONE,0,nil)
	local g=Duel.SelectTarget(tp,Card.IsFacedown,tp,LOCATION_MZONE,0,1,ct:GetCount(),nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c806000074.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if Duel.ChangePosition(g,POS_FACEUP_DEFENCE)>0 then
		local ct=Duel.GetMatchingGroup(c806000074.filter,tp,0,LOCATION_MZONE,nil)
		local sg=g:Filter(Card.IsSetCard,nil,0x8c)
		local sc=ct:Select(tp,1,sg:GetCount(),nil)
		Duel.ChangePosition(sc,POS_FACEDOWN_DEFENCE)
	end
end