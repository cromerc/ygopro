--Curry Pot
function c511001219.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_IGNORE_RANGE)
	e2:SetCode(EFFECT_TO_GRAVE_REDIRECT)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511001219.rmtarget)
	e2:SetTargetRange(0xff,0xff)
	e2:SetValue(LOCATION_REMOVED)
	c:RegisterEffect(e2)
	--instant(chain)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001219,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCondition(c511001219.condition)
	e3:SetCost(c511001219.cost)
	e3:SetTarget(c511001219.target)
	e3:SetOperation(c511001219.operation)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(81674782)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e4:SetTargetRange(0xff,0xff)
	e4:SetTarget(c511001219.checktg)
	c:RegisterEffect(e4)
end
function c511001219.rmtarget(e,c)
	if not c:IsLocation(0x80) and not c:IsType(TYPE_SPELL+TYPE_TRAP) then
		if c:GetOwner()==e:GetHandler():GetOwner() then
			c:RegisterFlagEffect(511001219,RESET_EVENT+0x1760000,0,0)
		end
		return true
	else
		return false
	end
end
function c511001219.spfilter(c,code)
	return c:GetCode()==code and c:GetFlagEffect(511001219)>0
end
function c511001219.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001219.spfilter,tp,LOCATION_REMOVED,0,1,nil,511001215)
		and Duel.IsExistingMatchingCard(c511001219.spfilter,tp,LOCATION_REMOVED,0,1,nil,511001216)
		and Duel.IsExistingMatchingCard(c511001219.spfilter,tp,LOCATION_REMOVED,0,1,nil,511001217)
end
function c511001219.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local ct=g:GetCount()
	if ct<1 then ct=1 end
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemoveAsCost,tp,LOCATION_MZONE,LOCATION_MZONE,ct,nil) end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511001219.filter(c,e,tp)
	return c:IsCode(511001218) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001219.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c511001219.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511001219.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001219.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511001219.checktg(e,c)
	return not c:IsPublic()
end
