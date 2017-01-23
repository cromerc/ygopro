--NO12 エーテリック・まへす
function c111011906.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,12,2)
	c:EnableReviveLimit()
	--addown
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(111011906,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c111011906.target)
	e1:SetOperation(c111011906.operation)
	c:RegisterEffect(e1)
	--Destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetOperation(c111011906.desop)
	c:RegisterEffect(e2)
end
function c111011906.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c111011906.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=e:GetHandler():GetOverlayGroup()
	local count=0
	local tc=g:GetFirst()
	while tc do
		if c111011906.filter(tc,e,tp) then
			count=count+1
		end
		tc=g:GetNext()
	end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if chk==0 then return ft>0 and ft>=count end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_OVERLAY)
end
function c111011906.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetOverlayGroup()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if ft<=0 or ft<g:GetCount() then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_INITIAL+EFFECT_FLAG_REPEAT)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetReset(RESET_EVENT+0x1ee0000+RESET_PHASE+PHASE_END)
	e1:SetCondition(c111011906.retcon)
	e1:SetOperation(c111011906.retop)
	c:RegisterEffect(e1)
	local sg=g:FilterSelect(tp,c111011906.filter,g:GetCount(),g:GetCount(),nil,e,tp)
	local tc=sg:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		c:SetCardTarget(tc)
		tc=sg:GetNext()
	end
	Duel.SpecialSummonComplete()
end
function c111011906.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetHandler():GetCardTarget()
	local tc=g:GetFirst()
	while  tc do
		if tc:IsLocation(LOCATION_MZONE) then
			Duel.Destroy(tc,REASON_EFFECT)
		end
		tc=g:GetNext()
	end
end
function c111011906.retcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetCardTarget()
	return tc:GetCount()>0
end
function c111011906.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=c:GetCardTarget()
	local tc=g:GetFirst()
	while tc do
		if tc:IsLocation(LOCATION_MZONE) then
			Duel.Overlay(c,tc)
		end
		tc=g:GetNext()
	end
end
