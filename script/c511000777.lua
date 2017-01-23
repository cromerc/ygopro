--Black Revenge
function c511000777.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000777.cost)
	e1:SetTarget(c511000777.target)
	e1:SetOperation(c511000777.activate)
	c:RegisterEffect(e1)
end
function c511000777.costfilter(c)
	return c:IsSetCard(0x33) and c:IsAbleToGraveAsCost()
end
function c511000777.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000777.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511000777.costfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511000777.filter(c)
	return c:IsFaceup() and c:GetAttackedCount()>0
end
function c511000777.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000777.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_MZONE,1,nil) end
end
function c511000777.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectMatchingCard(tp,c511000777.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	local g2=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
	if g1:GetCount()>0 and g2:GetCount()>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		g2:GetFirst():RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		g2:GetFirst():RegisterEffect(e2,true)
		Duel.CalculateDamage(g1:GetFirst(),g2:GetFirst())
	end
end
