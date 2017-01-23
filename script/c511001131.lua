--Clone Dragon
function c511001131.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c511001131.condition)
	e1:SetTarget(c511001131.target)
	e1:SetOperation(c511001131.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--attack cost
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_ATTACK_COST)
	e4:SetCost(c511001131.atcost)
	e4:SetOperation(c511001131.atop)
	c:RegisterEffect(e4)
end
function c511001131.atcost(e,c,tp)
	return Duel.CheckLPCost(tp,1000)
end
function c511001131.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.PayLPCost(tp,1000)
end
function c511001131.condition(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return ec:IsControler(tp) and eg:GetCount()==1
end
function c511001131.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ec=eg:GetFirst()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511001131.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=eg:GetFirst()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if c:IsRelateToEffect(e) and Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP) then
		if ec:IsRelateToEffect(e) and ec:IsFaceup() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_BASE_ATTACK)
			e1:SetValue(ec:GetAttack())
			e1:SetReset(RESET_EVENT+0xff0000)
			c:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_SET_BASE_DEFENSE)
			e2:SetValue(ec:GetDefense())
			c:RegisterEffect(e2)
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_CHANGE_CODE)
			e3:SetValue(ec:GetCode())
			e3:SetReset(RESET_EVENT+0x1ff0000)
			c:RegisterEffect(e3)	
		end
		Duel.SpecialSummonComplete()
	end
end
	