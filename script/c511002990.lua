--Victim's Darkness
function c511002990.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511002990.condition)
	e1:SetTarget(c511002990.target)
	e1:SetOperation(c511002990.operation)
	c:RegisterEffect(e1)
end
function c511002990.cfilter(c,e,tp)
	return c:IsOnField() and c:IsType(TYPE_MONSTER) and c:IsControler(tp) and (not e or c:IsRelateToEffect(e))
end
function c511002990.condition(e,tp,eg,ep,ev,re,r,rp)
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	if tg==nil then return false end
	local g=tg:Filter(c511002990.cfilter,nil,nil,tp)
	g:KeepAlive()
	e:SetLabelObject(g)
	return re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and ex and tc+g:GetCount()-tg:GetCount()==1
end
function c511002990.tgfilter(c)
	return c:IsLevelBelow(3) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsAbleToGrave()
end
function c511002990.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetLabelObject()
	if chk==0 then return g and Duel.IsExistingMatchingCard(c511002990.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c511002990.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c511002990.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoGrave(g,REASON_EFFECT)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
			e1:SetValue(1)
			e1:SetReset(RESET_CHAIN)
			tc:RegisterEffect(e1)
		end
	end
end
