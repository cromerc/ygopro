--Shark Lair
function c511001169.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001169.cost)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetTarget(c511001169.atktarget)
	c:RegisterEffect(e2)
	e1:SetLabelObject(e2)
end
function c511001169.cfilter(c)
	return c:IsRace(RACE_FISH) and c:IsAbleToGraveAsCost()
end
function c511001169.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001169.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511001169.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
	local atk=g:GetFirst():GetAttack()
	e:GetLabelObject():SetLabel(atk)
end
function c511001169.atktarget(e,c,atk)
	return c:GetAttack()<=e:GetLabel()
end
