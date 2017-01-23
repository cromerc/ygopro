--カードを狩る死神
function c511002504.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c511002504.atkop)
	c:RegisterEffect(e1)
end
function c511002504.atkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(23603403,0)) then
		Duel.Hint(HINT_CARD,0,511002504)
		local sc=g:Select(tp,1,1,nil):GetFirst()
		Duel.MoveToField(sc,sc:GetControler(),sc:GetControler(),LOCATION_MZONE,POS_FACEDOWN_DEFENSE,true)
		Duel.BreakEffect()
		if sc:IsControler(tp) then
			Duel.GetControl(sc,1-tp,PHASE_END)
		end
		Duel.ChangeAttackTarget(sc)
	end
end
