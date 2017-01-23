--ガチバトル！
function c511001233.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_STANDBY_PHASE)
	c:RegisterEffect(e1)
	--sp summon (main)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001233,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511001233.con)
	e2:SetCost(c511001233.cost)
	e2:SetTarget(c511001233.target)
	e2:SetOperation(c511001233.operation)
	c:RegisterEffect(e2)
	--sp summon (mp end)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE_START+PHASE_BATTLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetOperation(c511001233.acop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_PHASE_START+PHASE_END)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e5:SetDescription(aux.Stringid(511001233,0))
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(511001233)
	e5:SetCountLimit(1)
	e5:SetCost(c511001233.spcost)
	e5:SetTarget(c511001233.sptg)
	e5:SetOperation(c511001233.spop)
	c:RegisterEffect(e5)
end
function c511001233.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c511001233.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local regc=0
	local c=e:GetHandler()
	if tp==c:GetControler() then
		regc=51101233
	else
		regc=51101234
	end
	if chk==0 then return c:GetFlagEffect(regc)==0 end
	c:RegisterFlagEffect(regc,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511001233.filter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001233.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001233.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511001233.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001233.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e2:SetLabelObject(tc)
		e2:SetOperation(c511001233.desop)
		Duel.RegisterEffect(e2,tp)
	end
end
function c511001233.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c511001233.acop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseEvent(e:GetHandler(),511001233,e,0,tp,0,0)
end
function c511001233.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(51101233)==0 or c:GetFlagEffect(51101234)==0 end
	if c:GetFlagEffect(51101233)==0 then
		c:RegisterFlagEffect(51101233,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		c:RegisterFlagEffect(33,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
	if c:GetFlagEffect(51101234)==0 then
		c:RegisterFlagEffect(51101234,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		c:RegisterFlagEffect(34,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end
function c511001233.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,PLAYER_ALL,LOCATION_DECK)
end
function c511001233.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:GetFlagEffect(33)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511001233.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		local tc=g:GetFirst()
		if tc then
			Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP_ATTACK)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e2:SetCode(EVENT_PHASE+PHASE_END)
			e2:SetCountLimit(1)
			e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetLabelObject(tc)
			e2:SetOperation(c511001233.desop)
			Duel.RegisterEffect(e2,tp)
		end
	end
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and c:GetFlagEffect(34)>0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(1-tp,c511001233.filter,1-tp,LOCATION_DECK,0,1,1,nil,e,1-tp)
		local tc=g:GetFirst()
		if tc then
			Duel.SpecialSummon(tc,0,1-tp,1-tp,false,false,POS_FACEUP_ATTACK)
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e2:SetCode(EVENT_PHASE+PHASE_END)
			e2:SetCountLimit(1)
			e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetLabelObject(tc)
			e2:SetOperation(c511001233.desop)
			Duel.RegisterEffect(e2,1-tp)
		end
	end
end
