--Kuribabylon
function c511000150.initial_effect(c)
	--ss success
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511000150.atkcon)
	e1:SetOperation(c511000150.atkop)
	c:RegisterEffect(e1)
	--resummon (ignition)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511000150.spcost)
	e2:SetTarget(c511000150.sptg)
	e2:SetOperation(c511000150.spop)
	c:RegisterEffect(e2)
	--resummon (on attack)
	local e3=e2:Clone()
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_DISABLED)
	e3:SetCondition(c511000150.negcon)
	c:RegisterEffect(e3)
end
function c511000150.negcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst()==e:GetHandler()
end
function c511000150.atkcon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return rc:IsCode(511000153)
end
function c511000150.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetMaterial()
	local s1=0
	local s2=0
	local tc=g:GetFirst()
	while tc do
		local a1=tc:GetAttack()
		local a2=tc:GetPreviousAttackOnField()
		if a1<0 then a1=0 end
		if a2<0 then a2=0 end
		s1=s1+a1
		s2=s2+a2
		tc=g:GetNext()
	end
	local a=0
	if s1>s2 then
		a=s1
	else
		a=s2
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(a)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
end
function c511000150.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c511000150.filter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000150.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>3 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(c511000150.filter,tp,LOCATION_REMOVED,0,1,nil,e,tp,40640057) 
		and Duel.IsExistingMatchingCard(c511000150.filter,tp,LOCATION_REMOVED,0,1,nil,e,tp,511000153) 
		and Duel.IsExistingMatchingCard(c511000150.filter,tp,LOCATION_REMOVED,0,1,nil,e,tp,511000151) 
		and Duel.IsExistingMatchingCard(c511000150.filter,tp,LOCATION_REMOVED,0,1,nil,e,tp,511000152) 
		and Duel.IsExistingMatchingCard(c511000150.filter,tp,LOCATION_REMOVED,0,1,nil,e,tp,511000154) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,5,tp,LOCATION_REMOVED)
end
function c511000150.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=4 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g1=Duel.GetMatchingGroup(c511000150.filter,tp,LOCATION_REMOVED,0,nil,e,tp,40640057)
	local g2=Duel.GetMatchingGroup(c511000150.filter,tp,LOCATION_REMOVED,0,nil,e,tp,511000153)
	local g3=Duel.GetMatchingGroup(c511000150.filter,tp,LOCATION_REMOVED,0,nil,e,tp,511000151)
	local g4=Duel.GetMatchingGroup(c511000150.filter,tp,LOCATION_REMOVED,0,nil,e,tp,511000152)
	local g5=Duel.GetMatchingGroup(c511000150.filter,tp,LOCATION_REMOVED,0,nil,e,tp,511000154)
	if g1:GetCount()>0 and g2:GetCount()>0 and g3:GetCount()>0 and g4:GetCount()>0 and g5:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg2=g2:Select(tp,1,1,nil)
		sg1:Merge(sg2)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg3=g3:Select(tp,1,1,nil)
		sg1:Merge(sg3)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg4=g4:Select(tp,1,1,nil)
		sg1:Merge(sg4)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg5=g5:Select(tp,1,1,nil)
		sg1:Merge(sg5)
		Duel.SpecialSummon(sg1,0,tp,tp,false,false,POS_FACEUP)
	end
end
