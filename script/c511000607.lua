--Blue Moon
function c511000607.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_TOKEN+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000607.condition)
	e1:SetTarget(c511000607.target)
	e1:SetOperation(c511000607.activate)
	c:RegisterEffect(e1)
end
function c511000607.condition(e,tp,eg,ep,ev,re,r,rp)
	return false
end
function c511000607.filter(c)
	return c:IsFaceup() and c:IsDestructable() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511000607.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000608,0,0x4011,0,800,2,RACE_FAIRY,ATTRIBUTE_LIGHT) end
	if Duel.IsExistingMatchingCard(c511000607.filter,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511000607.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=nil
	local g2=nil
	if Duel.IsExistingMatchingCard(c511000607.filter,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		g1=Duel.SelectMatchingCard(tp,c511000607.filter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	end
	if Duel.IsExistingTarget(c511000607.filter,tp,0,LOCATION_ONFIELD,1,nil) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		g2=Duel.SelectMatchingCard(tp,c511000607.filter,tp,0,LOCATION_ONFIELD,1,1,nil)
	end
	if g1 and g2 then
		g1:Merge(g2)
		Duel.Destroy(g1,REASON_EFFECT)
	elseif g1 and not g2 then
		Duel.Destroy(g1,REASON_EFFECT)
	elseif g2 and not g1 then
		Duel.Destroy(g2,REASON_EFFECT)
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511000608,0,0x4011,0,800,2,RACE_FAIRY,ATTRIBUTE_LIGHT) then return end
	local p=0
	for i=1,2 do
		local token=Duel.CreateToken(tp,511000608)
		if p==0 then
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		else
			Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ADD_TYPE)
		e1:SetValue(TYPE_SPELL+TYPE_CONTINUOUS)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UNRELEASABLE_SUM)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e2,true)
		p=1
	end
	Duel.SpecialSummonComplete()
end
