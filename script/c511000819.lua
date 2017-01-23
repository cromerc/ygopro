--混沌帝龍 －終焉の使者－
function c511000819.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000819,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511000819.spcon)
	e1:SetOperation(c511000819.spop)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000819,1))
	e2:SetCategory(CATEGORY_TOGRAVE+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511000819.sgcost)
	e2:SetTarget(c511000819.sgtg)
	e2:SetOperation(c511000819.sgop)
	c:RegisterEffect(e2)
end
function c511000819.spfilter(c,att)
	return c:IsAttribute(att) and c:IsAbleToRemoveAsCost()
end
function c511000819.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000819.spfilter,tp,LOCATION_GRAVE,0,1,nil,ATTRIBUTE_LIGHT)
		and Duel.IsExistingMatchingCard(c511000819.spfilter,tp,LOCATION_GRAVE,0,1,nil,ATTRIBUTE_DARK)
end
function c511000819.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c511000819.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,ATTRIBUTE_LIGHT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c511000819.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,ATTRIBUTE_DARK)
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c511000819.sgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000)
	else Duel.PayLPCost(tp,1000) end
end
function c511000819.sgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetFieldGroup(tp,0xe,0xe)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,g:GetCount()*300)
end
function c511000819.sgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0xe,0xe)
	Duel.SendtoGrave(g,REASON_EFFECT)
	local og=Duel.GetOperatedGroup()
	local ct=og:FilterCount(Card.IsLocation,nil,LOCATION_GRAVE)
	Duel.BreakEffect()
	Duel.Damage(1-tp,ct*300,REASON_EFFECT)
end
