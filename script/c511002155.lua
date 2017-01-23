--Dark Alligator
function c511002155.initial_effect(c)
	--summon with 3 tribute
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(78651105,1))
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SUMMON_PROC)
	e3:SetCondition(c511002155.ttcon)
	e3:SetOperation(c511002155.ttop)
	e3:SetValue(SUMMON_TYPE_ADVANCE+1)
	c:RegisterEffect(e3)
	--sp summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(78651105,2))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetCondition(c511002155.spcon)
	e4:SetTarget(c511002155.sptg)
	e4:SetOperation(c511002155.spop)
	c:RegisterEffect(e4)
end
function c511002155.ttcon(e,c)
	if c==nil then return true end
	return Duel.GetTributeCount(c)>=4
end
function c511002155.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectTribute(tp,c,4,4)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c511002155.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_ADVANCE+1
end
function c511002155.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c511002155.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if ft<2 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,511002156,0,0x4011,2000,0,4,RACE_REPTILE,0) then return end
	for i=1,2 do
		local token=Duel.CreateToken(tp,511002156)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
