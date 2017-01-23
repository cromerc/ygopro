--カオス狂宴
function c511001187.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001187.exscon)
	e1:SetCost(c511001187.cost)
	e1:SetTarget(c511001187.target)
	e1:SetOperation(c511001187.activate)
	c:RegisterEffect(e1)
end
function c511001187.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1048)
end
function c511001187.exscon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001187.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511001187.filter(c)
	return c:IsCode(511001186) and c:IsAbleToGraveAsCost() 
end
function c511001187.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001187.filter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511001187.filter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511001187.spfilter(c,e,tp)
	local code=c:GetCode()
	local class=_G["c"..code]
	if class==nil then return false end
	local no=class.xyz_number
	return c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,true,false) 
		and no and no>=101 and no<=107 and c:IsSetCard(0x1048) 
end
function c511001187.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>2 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(c511001187.spfilter,tp,LOCATION_EXTRA,0,3,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,tp,LOCATION_EXTRA)
end
function c511001187.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<3 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetMatchingGroup(c511001187.spfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
	if g:GetCount()<3 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=g:Select(tp,3,3,nil)
	local tc=sg:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,SUMMON_TYPE_XYZ,tp,tp,true,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2,true)
		tc:CompleteProcedure()
		tc=sg:GetNext()
	end
	Duel.SpecialSummonComplete()
end
