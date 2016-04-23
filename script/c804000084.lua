--Trifortressops
function c804000084.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(804000084,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_ATTACK+TIMING_SUMMON+TIMING_SPSUMMON+TIMING_FLIPSUMMON)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c804000084.condition)
	e1:SetTarget(c804000084.hsptg)
	e1:SetOperation(c804000084.hspop)
	c:RegisterEffect(e1)
	if not c804000084.global_check then
		c804000084.global_check=true
		c804000084[0]=0
		c804000084[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c804000084.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
		ge2:SetOperation(c804000084.checkop)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge3:SetOperation(c804000084.checkop)
		Duel.RegisterEffect(ge3,0)
	end
end
function c804000084.checkop(e,tp,eg,ep,ev,re,r,rp)
	local turnp=e:GetHandler():GetControler()
	if Duel.GetTurnCount()~=c804000084[2] then
		c804000084[0]=0
		c804000084[1]=0
		c804000084[2]=Duel.GetTurnCount()
	end
	local tc=eg:GetFirst()
	while tc do
		local sp=tc:GetSummonPlayer()
		c804000084[sp]=c804000084[sp]+1
		if c804000084[sp]==3 and sp~=turnp then
			Duel.RegisterFlagEffect(turnp,804000084,RESET_PHASE+PHASE_END,0,1)
		end
		tc=eg:GetNext()
	end
end
function c804000084.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,804000084)~=0 and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c804000084.hsptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c804000084.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetCountLimit(1)
		e1:SetProperty(EFFECT_FLAG_REPEAT)
		e1:SetOperation(c804000084.defop)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_IMMUNE_EFFECT)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e2)
	end
end
function c804000084.defop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENCE)
		e1:SetValue(-500)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end