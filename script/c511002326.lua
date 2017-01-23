--Divine Castle Gate
function c511002326.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511002326.cost)
	e1:SetOperation(c511002326.activate)
	c:RegisterEffect(e1)
end
function c511002326.costfilter(c)
	return c:IsCode(511002318) and c:IsAbleToGraveAsCost()
end
function c511002326.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002326.costfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local tc=Duel.SelectMatchingCard(tp,c511002326.costfilter,tp,LOCATION_ONFIELD,0,1,1,nil):GetFirst()
	if tc:IsFacedown() then Duel.ConfirmCards(1-tp,tc) end
	Duel.SendtoGrave(tc,REASON_COST)
end
function c511002326.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(c511002326.damval)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511002326.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_BATTLE)~=0 then
		return val/2
	else
		return val
	end
end
