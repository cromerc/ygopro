--カオス・エンド・ルーラー －開闢と終焉の支配者－
function c100000000.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000000,0))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetHintTiming(0,0x1e0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c100000000.spcon)
	e1:SetOperation(c100000000.spop)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000000,1))
	e2:SetCategory(CATEGORY_REMOVE+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c100000000.sgcost)
	e2:SetTarget(c100000000.sgtg)
	e2:SetOperation(c100000000.sgop)
	c:RegisterEffect(e2)
	--summon success
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c100000000.sumsuc)
	c:RegisterEffect(e3)
	--Cannot be responded
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_DISABLE_SPSUMMON)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	c:RegisterEffect(e4)
end
function c100000000.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetChainLimitTillChainEnd(aux.FALSE)
end
function c100000000.spfilter(c,att,race)
	return c:IsAttribute(att) and c:IsAbleToRemoveAsCost() and c:IsRace(race)
end
function c100000000.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000000.spfilter,tp,LOCATION_GRAVE,0,1,nil,ATTRIBUTE_LIGHT,RACE_WARRIOR)
		and Duel.IsExistingMatchingCard(c100000000.spfilter,tp,LOCATION_GRAVE,0,1,nil,ATTRIBUTE_DARK,RACE_FIEND)
end
function c100000000.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c100000000.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,ATTRIBUTE_LIGHT,RACE_WARRIOR)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g2=Duel.SelectMatchingCard(tp,c100000000.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,ATTRIBUTE_DARK,RACE_FIEND)
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
end
function c100000000.sgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000)
	else Duel.PayLPCost(tp,1000) end
end
function c100000000.sgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,0x1e,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,1-tp,g:GetCount()*500)
end
function c100000000.sgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,0x1e,e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	local og=Duel.GetOperatedGroup()
	local ct=og:FilterCount(Card.IsLocation,nil,LOCATION_REMOVED)
	Duel.Damage(1-tp,ct*500,REASON_EFFECT)
end

