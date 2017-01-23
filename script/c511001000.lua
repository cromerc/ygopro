--Return Talisman
function c511001000.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001000,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetCondition(c511001000.spcon)
	e2:SetTarget(c511001000.sptg)
	e2:SetOperation(c511001000.spop)
	c:RegisterEffect(e2)
end
function c511001000.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetActivityCount(1-tp,ACTIVITY_NORMALSUMMON)==0 
		and Duel.GetActivityCount(1-tp,ACTIVITY_SPSUMMON)==0 and Duel.GetActivityCount(1-tp,ACTIVITY_FLIPSUMMON)==0
end
function c511001000.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
end
function c511001000.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511001001,0,0x4011,1000,1000,2,RACE_FAIRY,ATTRIBUTE_DARK,POS_FACEUP_DEFENSE,1-tp) then
		local token=Duel.CreateToken(tp,511001001)
		Duel.SpecialSummon(token,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
	end
end
