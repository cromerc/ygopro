--Spinning Wheel Spindle
--Jackpro 1.3
function c511001420.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001420.target)
	e1:SetOperation(c511001420.activate)
	c:RegisterEffect(e1)
end
function c511001420.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511001420.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		if Duel.Destroy(g,REASON_EFFECT)>0 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetCountLimit(1)
			e1:SetOperation(c511001420.retop)
			e1:SetLabel(0)
			e1:SetLabelObject(g:GetFirst())
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,3)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c511001420.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if Duel.GetTurnPlayer()~=tp then return end
	local ct=e:GetLabel()
	ct=ct+1
	e:SetLabel(ct)
	e:GetHandler():SetTurnCounter(ct)
	if ct==3 and g and g:IsLocation(LOCATION_GRAVE) then
		Duel.SpecialSummon(g,0,1-tp,1-tp,false,false,POS_FACEUP_ATTACK)
	end
end
