--邪龍復活の儀式
function c120000016.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c120000016.cost)
	e1:SetTarget(c120000016.target)
	e1:SetOperation(c120000016.activate)
	c:RegisterEffect(e1)
end
c120000016.fit_monster={99267150}
function c120000016.cfilter1(c,rg)
	if not c:IsAttribute(ATTRIBUTE_WIND) then return false end
	rg:RemoveCard(c)
	local ret=rg:IsExists(c120000016.cfilter2,1,nil,rg)
	rg:AddCard(c)
	return ret
end
function c120000016.cfilter2(c,rg)
	if not c:IsAttribute(ATTRIBUTE_WATER) then return false end
	rg:RemoveCard(c)
	local ret=rg:IsExists(c120000016.cfilter3,1,nil,rg)
	rg:AddCard(c)
	return ret
end
function c120000016.cfilter3(c,rg)
	if not c:IsAttribute(ATTRIBUTE_FIRE) then return false end
	rg:RemoveCard(c)
	local ret=rg:IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_EARTH)
	rg:AddCard(c)
	return ret
end
function c120000016.cfilter4(c,rg)
	if not c:IsAttribute(ATTRIBUTE_EARTH) then return false end
	rg:RemoveCard(c)
	local ret=rg:IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_WIND)
	rg:AddCard(c)
	return ret
end
function c120000016.cfilter5(c,rg)
	if not c:IsAttribute(ATTRIBUTE_DARK) then return false end
	rg:RemoveCard(c)
	local ret=rg:IsExists(Card.IsAttribute,1,nil,ATTRIBUTE_WATER)
	rg:AddCard(c)
	return ret
end
function c120000016.rfilter(c)
	return c:IsFaceup() and c:IsHasEffect(EFFECT_EXTRA_RELEASE) and c:IsReleasable()
end
function c120000016.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g1=Duel.GetMatchingGroup(Card.IsReleasable,tp,LOCATION_MZONE+LOCATION_HAND,0,nil)
	local g2=Duel.GetMatchingGroup(c120000016.rfilter,tp,LOCATION_MZONE+LOCATION_HAND,0,nil)
	g1:Merge(g2)
	if chk==0 then return g1:GetCount()>=6 and g1:IsExists(c120000016.cfilter1,1,nil,g1) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local rg1=g1:FilterSelect(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_WATER)
	g1:Sub(rg1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local rg2=g1:FilterSelect(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_FIRE)
	g1:Sub(rg2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local rg3=g1:FilterSelect(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_WIND)
	g1:Sub(rg3)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local rg4=g1:FilterSelect(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_EARTH)
	g1:Sub(rg4)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local rg5=g1:FilterSelect(tp,Card.IsAttribute,1,1,nil,ATTRIBUTE_DARK)
	g1:Sub(rg5)
	rg1:Merge(rg2)
	rg1:Merge(rg3)
	rg1:Merge(rg4)
	rg1:Merge(rg5)
	Duel.Release(rg1,REASON_COST)
	Duel.Release(rg2,REASON_COST)
	Duel.Release(rg3,REASON_COST)
	Duel.Release(rg4,REASON_COST)
	Duel.Release(rg5,REASON_COST)
end
function c120000016.spfilter(c,e,tp)
	return c:IsCode(99267150) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c120000016.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c120000016.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
	g=Duel.GetMatchingGroup(c120000016.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end

function c120000016.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectMatchingCard(tp,c120000016.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if sg:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SpecialSummon(sg,SUMMON_TYPE_FUSION,tp,tp,true,false,POS_FACEUP)
		sg:GetFirst():CompleteProcedure()
		local g=Duel.GetMatchingGroup(c120000016.filter,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(g,REASON_EFFECT)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
		e1:SetProperty(EFFECT_FLAG_OATH)
		e1:SetTarget(aux.TargetBoolFunction(Card.IsCode,99267150))
		e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
