--Infernoid Beelzebul
function c13700035.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon G/H
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c13700035.spcon)
	e2:SetOperation(c13700035.spop)
	c:RegisterEffect(e2)
	--special summon G/H/F
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c13700035.spcon2)
	e2:SetOperation(c13700035.spop2)
	c:RegisterEffect(e2)
	--~ ToHand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c13700035.target)
	e1:SetOperation(c13700035.operation)
	c:RegisterEffect(e1)
	--Banish
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c13700035.cost2)
	e1:SetCondition(c13700035.condition2)
	e1:SetTarget(c13700035.target2)
	e1:SetOperation(c13700035.operation2)
	c:RegisterEffect(e1)
end
function c13700035.filter(c)--Overflowing Purgatory
	return c:IsFaceup() and c:IsCode(13700039) and not c:IsDisabled()
end
function c13700035.emfilter(c)--Grupo EFFECT-MZONE
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c13700035.spfilter(c)
	return c:IsSetCard(0x1379) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c13700035.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c13700035.emfilter,tp,LOCATION_MZONE,0,nil)
	local lvs=g:GetSum(Card.GetLevel)
	local rks=g:GetSum(Card.GetRank)
	local tlr=lvs+rks
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and tlr<9
		and Duel.IsExistingMatchingCard(c13700035.spfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,c)
	and	not Duel.IsExistingMatchingCard(c13700035.filter,tp,LOCATION_SZONE,0,1,nil)
end
function c13700035.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c13700035.spfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,1,1,c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end

function c13700035.spcon2(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c13700035.emfilter,tp,LOCATION_MZONE,0,nil)
	local lvs=g:GetSum(Card.GetLevel)
	local rks=g:GetSum(Card.GetRank)
	local tlr=lvs+rks
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and tlr<9
		and Duel.IsExistingMatchingCard(c13700035.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_HAND,0,1,c)
	and	Duel.IsExistingMatchingCard(c13700035.filter,tp,LOCATION_SZONE,0,1,nil)
end
function c13700035.spop2(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c13700035.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_HAND,0,1,1,c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
--~ ToHand
function c13700035.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c13700035.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
--~ Banish
function c13700035.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c13700035.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local cg=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(cg,REASON_COST)
end
function c13700035.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(1-tp) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,0,LOCATION_GRAVE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c13700035.operation2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end
end
