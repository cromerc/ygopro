--Colorless, Chaos King of Dark World
function c511000501.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,99458769,34230233,true,true)
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(c511000501.splimit)
	c:RegisterEffect(e0)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c511000501.spcon)
	e1:SetOperation(c511000501.spop)
	e1:SetValue(SUMMON_TYPE_FUSION)
	c:RegisterEffect(e1)
	--discard
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000501,0))
	e2:SetCategory(CATEGORY_HANDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c511000501.target)
	e2:SetOperation(c511000501.op)
	c:RegisterEffect(e2)
	--shuffle
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(10028593,4))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetTarget(c511000501.tdtg)
	e3:SetOperation(c511000501.tdop)
	c:RegisterEffect(e3)
end
function c511000501.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c511000501.spfilter1(c)
	return c:IsFaceup() and c:IsCode(34230233) and c:IsAbleToRemove()
end
function c511000501.spfilter2(c)
	return c:IsSetCard(0x6) and c:IsAbleToGrave()
end
function c511000501.spcon(e,c)
	if c==nil then return true end
	return Duel.IsExistingMatchingCard(c511000501.spfilter1,c:GetControler(),LOCATION_MZONE,0,1,nil)
	and Duel.IsExistingMatchingCard(c511000501.spfilter2,c:GetControler(),LOCATION_HAND,0,2,nil)
end
function c511000501.spop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c511000501.spfilter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g2=Duel.SelectMatchingCard(tp,c511000501.spfilter2,tp,LOCATION_HAND,0,2,2,nil)
	Duel.Remove(g1,POS_FACEUP,REASON_COST)
	Duel.SendtoGrave(g2,REASON_COST)
end
function c511000501.dfilter(c)
	return c:IsRace(RACE_FIEND) and c:IsDiscardable()
end
function c511000501.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000501.dfilter,tp,LOCATION_HAND,0,1,nil) end
	local op=0
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(511000501,1))
	if Duel.GetCurrentPhase()==PHASE_MAIN1 then
		op=Duel.SelectOption(tp,aux.Stringid(511000501,2),aux.Stringid(511000501,3))
	else
		Duel.SelectOption(tp,aux.Stringid(511000501,2))
		op=0
	end
	e:SetLabel(op)
	if op==1 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetProperty(EFFECT_FLAG_OATH)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetTarget(c511000501.ftarget)
		e1:SetLabel(e:GetHandler():GetFieldID())
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c511000501.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
function c511000501.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==0 then
		local e1=Effect.CreateEffect(e:GetHandler())	
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e1:SetCode(EVENT_CHAIN_SOLVED)
		e1:SetOperation(c511000501.activate)
		e1:SetReset(RESET_CHAIN)
		Duel.RegisterEffect(e1,1-tp)
	else
		local g=Duel.GetMatchingGroup(c511000501.dfilter,tp,LOCATION_HAND,0,nil)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
		if sg:GetCount()>0 and c:IsFaceup() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(sg:GetFirst():GetAttack())
			e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e1)
			--Extra attack
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e2:SetCode(EFFECT_EXTRA_ATTACK)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
			c:RegisterEffect(e2)
		end
	end
end
function c511000501.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511000501.dfilter,1-tp,LOCATION_HAND,0,nil)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_DISCARD)
		local sg=g:Select(1-tp,1,1,nil)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
	end
end
function c511000501.tdfilter(c,e,tp)
	return c:IsSetCard(0x6) and c:GetCode()~=511000501
end
function c511000501.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000501.tdfilter,tp,LOCATION_REMOVED,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_REMOVED)
end
function c511000501.tdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511000501.tdfilter,tp,LOCATION_REMOVED,0,nil)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end
