--見下した条約
function c511001214.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001214.condition)
	e1:SetOperation(c511001214.operation)
	c:RegisterEffect(e1)
end
function c511001214.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511001214.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetLabel(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c511001214.spcon)
	e2:SetOperation(c511001214.spop)
	e2:SetLabelObject(e1)
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,1-tp)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(c511001214.spcon2)
	Duel.RegisterEffect(e3,1-tp)
	local e4=e2:Clone()
	e4:SetCode(EVENT_CHAIN_END)
	Duel.RegisterEffect(e4,1-tp)
	local e5=e2:Clone()
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	Duel.RegisterEffect(e5,1-tp)
	local e6=e2:Clone()
	e6:SetCode(EVENT_DAMAGE_STEP_END)
	Duel.RegisterEffect(e6,1-tp)
	local e7=e2:Clone()
	e7:SetCode(EVENT_PHASE+PHASE_END)
	Duel.RegisterEffect(e7,1-tp)
	local e8=Effect.CreateEffect(e:GetHandler())
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_ADJUST)
	e8:SetLabelObject(e1)
	e8:SetCondition(c511001214.spcon)
	e8:SetOperation(c511001214.regop)
	e8:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e8,1-tp)
	local e10=Effect.CreateEffect(e:GetHandler())
	e10:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e10:SetCode(511001213)
	e10:SetCountLimit(1)
	e10:SetProperty(EFFECT_FLAG_DELAY)
	e10:SetCondition(c511001214.accon)
	e10:SetOperation(c511001214.damop)
	e10:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e10,tp)
end
function c511001214.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsLevelBelow(4)
end
function c511001214.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetLabel()==1
end
function c511001214.spcon2(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject():GetLabel()==1 and Duel.GetCurrentChain()==0
end
function c511001214.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetLabel()~=1 then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001214.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp)
		and Duel.SelectYesNo(tp,aux.Stringid(511001214,0)) then
		e:GetLabelObject():SetLabel(0)
		Duel.Hint(HINT_CARD,0,511001214)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511001214.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		Duel.Hint(HINT_CARD,0,511001214)
		Duel.Draw(1-tp,2,REASON_EFFECT)
	elseif Duel.GetCurrentPhase()==PHASE_END then
		Duel.RaiseEvent(e:GetHandler(),511001213,e,0,tp,0,0)
	end
end
function c511001214.regop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetLabel()~=1 then return end
	local tc=Duel.GetDecktopGroup(tp,1):GetFirst()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC_G)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_DECK)
	e1:SetCountLimit(1)
	e1:SetLabelObject(e:GetLabelObject())
	e1:SetCondition(c511001214.spcon3)
	e1:SetOperation(c511001214.spop3)
	e1:SetReset(RESET_EVENT+EVENT_ADJUST)
	tc:RegisterEffect(e1)
end
function c511001214.spcon3(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:GetLabelObject():GetLabel()==1
		and Duel.IsExistingMatchingCard(c511001214.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp)
end
function c511001214.spop3(e,tp,eg,ep,ev,re,r,rp,c,og)
	Duel.Hint(HINT_CARD,0,511001214)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001214.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	og:Merge(g)
	e:GetLabelObject():SetLabel(0)
	Duel.Hint(HINT_CARD,0,511001214)
	Duel.Draw(1-tp,2,REASON_EFFECT)
end
function c511001214.accon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c511001214.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511001214)
	Duel.Damage(tp,1000,REASON_EFFECT)
end
