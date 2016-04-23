--Infernoid Nehemoth
function c13700037.initial_effect(c)
	c:SetStatus(STATUS_UNSUMMONABLE_CARD,true)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCondition(c13700037.spcon)
	e2:SetOperation(c13700037.spop)
	c:RegisterEffect(e2)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e2:SetCondition(c13700037.spcon2)
	e2:SetOperation(c13700037.spop2)
	c:RegisterEffect(e2)
	--remove
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(4335427,0))
	e4:SetCategory(CATEGORY_REMOVE)
	e4:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetTarget(c13700037.rmtg)
	e4:SetOperation(c13700037.rmop)
	c:RegisterEffect(e4)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c13700037.cost)
	e1:SetCondition(c13700037.condition)
	e1:SetTarget(c13700037.target)
	e1:SetOperation(c13700037.activate)
	c:RegisterEffect(e1)
	
end
--~ Invocacion
function c13700037.filter(c)--Overflowing Purgatory
	return c:IsFaceup() and c:IsCode(13700039) and not c:IsDisabled()
end
function c13700037.emfilter(c)--Grupo EFFECT-MZONE
	return c:IsFaceup() and c:IsType(TYPE_EFFECT)
end
function c13700037.spfilter(c)
	return c:IsSetCard(0x1379) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost()
end
function c13700037.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c13700037.emfilter,tp,LOCATION_MZONE,0,nil)
	local lvs=g:GetSum(Card.GetLevel)
	local rks=g:GetSum(Card.GetRank)
	local tlr=lvs+rks
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and tlr<9
		and Duel.IsExistingMatchingCard(c13700037.spfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,3,c)
	and	not Duel.IsExistingMatchingCard(c13700037.filter,tp,LOCATION_SZONE,0,1,nil)
end
function c13700037.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c13700037.spfilter,tp,LOCATION_GRAVE+LOCATION_HAND,0,3,3,c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end

function c13700037.spcon2(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c13700037.emfilter,tp,LOCATION_MZONE,0,nil)
	local lvs=g:GetSum(Card.GetLevel)
	local rks=g:GetSum(Card.GetRank)
	local tlr=lvs+rks
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and tlr<9
		and Duel.IsExistingMatchingCard(c13700037.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_HAND,0,3,c)
	and	Duel.IsExistingMatchingCard(c13700037.filter,tp,LOCATION_SZONE,0,1,nil)
end
function c13700037.spop2(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c13700037.spfilter,tp,LOCATION_MZONE+LOCATION_GRAVE+LOCATION_HAND,0,3,3,c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end


function c13700037.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	Duel.SetChainLimit(aux.FALSE)
end
function c13700037.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.Destroy(g,REASON_EFFECT)
end


function c13700037.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local cg=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(cg,REASON_COST)
end
function c13700037.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and Duel.IsChainNegatable(ev)
end
function c13700037.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_REMOVE,eg,1,0,0)
	end
end
function c13700037.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Remove(re:GetHandler(),POS_FACEUP,REASON_EFFECT)
	end
end
