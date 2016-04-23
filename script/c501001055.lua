---カバーカーニバル
function c501001055.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c501001055.target)
	e1:SetOperation(c501001055.activate)
	c:RegisterEffect(e1)
end	
function c501001055.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=3
	and Duel.IsPlayerCanSpecialSummonMonster(tp,501001091,0,0x4011,0,0,1,RACE_BEAST,ATTRIBUTE_EARTH)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,3,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,0,0)
end
function c501001055.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>=3 
	and Duel.IsPlayerCanSpecialSummonMonster(tp,501001091,0,0x4011,0,0,1,RACE_BEAST,ATTRIBUTE_EARTH) then
		for i=1,3 do
			local token=Duel.CreateToken(tp,501001091)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			--
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UNRELEASABLE_SUM)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e1,true)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
			token:RegisterEffect(e2)
			--
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_FIELD)
			e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
			e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e3:SetRange(LOCATION_MZONE)
			e3:SetTargetRange(1,0)
			e3:SetTarget(c501001055.splimit)
			token:RegisterEffect(e3)
		end
		Duel.SpecialSummonComplete()
	end
	--
	local ge1=Effect.CreateEffect(e:GetHandler())
	ge1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	ge1:SetType(EFFECT_TYPE_FIELD)
	ge1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	ge1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	ge1:SetTarget(c501001055.bctg)
	ge1:SetValue(1)
	ge1:SetReset(RESET_PHASE+PHASE_END,1)
	Duel.RegisterEffect(ge1,tp)
end
function c501001055.splimit(e,c)
	return c:IsLocation(LOCATION_EXTRA)
end
function c501001055.bctg(e,c)
	return not c:IsCode(501001091)
end
