--Dark Matter
function c511000043.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511000043.condition)
	e1:SetTarget(c511000043.target)
	e1:SetOperation(c511000043.activate)
	c:RegisterEffect(e1)
end
function c511000043.cfilter(c,tp)
	return c:IsType(TYPE_SYNCHRO) and c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousPosition(POS_FACEUP) and c:IsAttribute(ATTRIBUTE_DARK) 
end
function c511000043.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000043.cfilter,1,nil,tp)
end
function c511000043.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000042,0,0x4011,0,0,1,RACE_FIEND,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c511000043.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000042,0,0x4011,0,0,1,RACE_FIEND,ATTRIBUTE_DARK) then
		for i=1,2 do
			local token=Duel.CreateToken(tp,511000042)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetValue(1)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e1)
			local de=Effect.CreateEffect(e:GetHandler())
			de:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			de:SetRange(LOCATION_MZONE)
			de:SetCode(EVENT_PHASE+PHASE_END)
			de:SetOperation(c511000043.desop)
			de:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(de)
		end
		Duel.SpecialSummonComplete()
	end
end
function c511000043.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end