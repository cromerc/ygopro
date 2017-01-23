--Chaos Bringer
function c511000986.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511000986.condition)
	e1:SetTarget(c511000986.target)
	e1:SetOperation(c511000986.activate)
	c:RegisterEffect(e1)
end
function c511000986.cfilter(c)
	return c:IsType(TYPE_XYZ) and (c:IsSetCard(0x1048) or c:IsSetCard(0x1073) or c:IsCode(511000296)) and c:GetOverlayCount()>0
end
function c511000986.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000986.cfilter,nil)
	return g:GetCount()==1 and ep~=tp
end
function c511000986.filter(c)
	return c:IsCode(111011002) and c:IsAbleToHand()
end
function c511000986.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000986.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c511000986.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000986.cfilter,nil):GetFirst()
	g:RemoveOverlayCard(tp,g:GetOverlayCount(),g:GetOverlayCount(),REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511000986.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e1:SetTarget(c511000986.atktarget)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		Duel.RegisterEffect(e1,tp)	
	end
end
function c511000986.atktarget(e,c)
	return c:IsSetCard(0x1048) or c:IsSetCard(0x1073) or c:IsCode(511000296)
end
