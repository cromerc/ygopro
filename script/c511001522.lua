--Wall of Ivy (Anime)
function c511001522.initial_effect(c)
	--sp summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001522,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetTarget(c511001522.tg)
	e1:SetOperation(c511001522.op)
	c:RegisterEffect(e1)
end
function c511001522.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
end
function c511001522.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,30069399,0,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH,POS_FACEUP_DEFENSE,1-tp) then
		local token=Duel.CreateToken(tp,30069399)
		if Duel.SpecialSummonStep(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_DESTROY)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetOperation(c511001522.damop)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e1,true)
		end
		Duel.SpecialSummonComplete()
	end
end
function c511001522.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,300,REASON_EFFECT)
end
