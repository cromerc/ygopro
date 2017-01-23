--Explosive Blast
function c511002887.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002887.condition)
	e1:SetTarget(c511002887.target)
	e1:SetOperation(c511002887.activate)
	c:RegisterEffect(e1)
end
function c511002887.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511002887.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and c:GetBattledGroupCount()==0
end
function c511002887.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511002887.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002887.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511002887.filter,tp,LOCATION_MZONE,0,1,3,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*400)
end
function c511002887.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ct=Duel.Destroy(sg,REASON_EFFECT)
	if ct~=0 then
		Duel.BreakEffect()
		Duel.Damage(1-tp,ct*400,REASON_EFFECT)
	end
end
