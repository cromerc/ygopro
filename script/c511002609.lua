--Eruption of Fire
function c511002609.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511002609.condition)
	e1:SetTarget(c511002609.target)
	e1:SetOperation(c511002609.activate)
	c:RegisterEffect(e1)
end
function c511002609.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsControler,1,nil,1-tp)
end
function c511002609.filter(c,tp)
	return c:IsCode(19384334) and c:GetActivateEffect():IsActivatable(tp)
end
function c511002609.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002609.filter,tp,LOCATION_DECK,0,1,nil,tp) end
end
function c511002609.tgfilter(c)
	return c:GetSequence()<5 and c:IsAbleToGrave()
end
function c511002609.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EFFECT)
	local tc=Duel.SelectMatchingCard(tp,c511002609.filter,tp,LOCATION_DECK,0,1,1,nil,tp):GetFirst()
	if tc then
		local fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
		if fc then
			Duel.SendtoGrave(fc,REASON_RULE)
			Duel.BreakEffect()
		end
		fc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
		local fchk=fc and fc:IsFaceup()
		Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		local g=Duel.GetMatchingGroup(c511002609.tgfilter,tp,LOCATION_SZONE,0,e:GetHandler())
		if fchk and g:GetCount()>0 and Duel.SelectYesNo(1-tp,aux.Stringid(2843014,0)) then
			Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
			local tg=g:Select(1-tp,1,1,nil)
			Duel.SendtoGrave(tg,REASON_EFFECT)
			local dg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
			if dg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(28553439,0)) then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
				local des=dg:Select(tp,1,1,nil)
				Duel.HintSelection(des)
				Duel.BreakEffect()
				Duel.Destroy(des,REASON_EFFECT)
			end
		end
		Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,tc:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
	end
end
