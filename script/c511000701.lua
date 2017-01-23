--Xyz Barrier
function c511000701.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_BATTLE_PHASE,0x1c0+TIMING_BATTLE_PHASE)
	e1:SetTarget(c511000701.target)
	e1:SetOperation(c511000701.activate)
	c:RegisterEffect(e1)
end
function c511000701.filter(c)
	return c:IsType(TYPE_XYZ)
end
function c511000701.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000701.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
end
function c511000701.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c511000701.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetValue(1)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		g:GetFirst():RegisterEffect(e2)	
	end
end
