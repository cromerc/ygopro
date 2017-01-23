--Magic Law
function c511000980.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--send
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000980,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511000980.tg)
	e2:SetOperation(c511000980.op)
	c:RegisterEffect(e2)
end
function c511000980.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
		and Duel.IsExistingMatchingCard(c511000980.filter,tp,LOCATION_HAND,0,2,c,c:GetCode())
end
function c511000980.filter(c,code)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToGrave() and c:IsCode(code)
end
function c511000980.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c511000980.tgfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND)
end
function c511000980.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000980.tgfilter,tp,LOCATION_HAND,0,1,1,nil)
	if g:GetCount()>0 then
		local g2=Duel.SelectMatchingCard(tp,c511000980.filter,tp,LOCATION_HAND,0,2,2,g:GetFirst(),g:GetFirst():GetCode())
		g:Merge(g2)
		if Duel.SendtoGrave(g,REASON_EFFECT)~=0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetCode(EFFECT_CANNOT_ACTIVATE)
			e1:SetTargetRange(0,1)
			e1:SetValue(c511000980.aclimit)
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c511000980.aclimit(e,re,tp)
	return re:GetHandler():IsType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
