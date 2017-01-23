--Defense Drain
function c511002803.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetTarget(c511002803.target)
	e1:SetOperation(c511002803.activate)
	c:RegisterEffect(e1)
end
function c511002803.filter(c)
	return c:IsFaceup() and c:GetDefense()>0
end
function c511002803.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002803.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
end
function c511002803.activate(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetMatchingGroup(c511002803.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local g2=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)
	if g1:GetCount()>0 and g2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(52128900,0))
		local sg1=g1:Select(tp,1,1,nil)
		local tc1=sg1:GetFirst()
		Duel.HintSelection(sg1)
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(52128900,1))
		local sg2=g2:Select(tp,1,1,nil)
		local tc2=sg2:GetFirst()
		Duel.HintSelection(sg2)
		local def=tc1:GetDefense()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(0)
		if tc1:RegisterEffect(e1) then
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(def)
			tc2:RegisterEffect(e2)
		end
	end
end
