--武神帝―カグツチ
function c806000053.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunctionF(c,aux.FilterBoolFunction(Card.IsRace,RACE_BEASTWARRIOR),4),2)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c806000053.condition)
	e1:SetTarget(c806000053.target)
	e1:SetOperation(c806000053.operation)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c806000053.reptg)
	e2:SetValue(c806000053.repval)
	e2:SetOperation(c806000053.repop)
	c:RegisterEffect(e2)
end
function c806000053.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
end
function c806000053.cfilter(c)
	return c:IsLocation(LOCATION_GRAVE) and c:IsSetCard(0x88) and c:IsType(TYPE_MONSTER)
end
function c806000053.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(tp,5) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,5)
end
function c806000053.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,5,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	local ct=g:FilterCount(c806000053.cfilter,nil)
	if ct==0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e1:SetValue(ct*100)
	e:GetHandler():RegisterEffect(e1)
end
function c806000053.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0x88)
end
function c806000053.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c806000053.repfilter,1,nil,tp) end
	if Duel.SelectYesNo(tp,aux.Stringid(25341652,1)) and e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) then
		local g=eg:Filter(c806000053.repfilter,nil,tp)
		Duel.SetTargetCard(g)
		return true
	else return false end
end
function c806000053.repval(e,c)
	return c806000053.repfilter(c,e:GetHandlerPlayer())
end
function c806000053.repop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	while tc and e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) do
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		tc=g:GetNext()
	end
	g:DeleteGroup()
end
