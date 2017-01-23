--サイクロン
function c511001250.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001250.target)
	e1:SetOperation(c511001250.activate)
	c:RegisterEffect(e1)
end
function c511001250.dfilter(c)
	return c:IsDestructable() and c:IsFaceup() and c:IsType(TYPE_FIELD)
end
function c511001250.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c511001250.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001250.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local g=Duel.GetMatchingGroup(c511001250.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511001250.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local tc=Duel.SelectMatchingCard(tp,c511001250.dfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	if tc:GetCount()>0 then
		Duel.HintSelection(tc)
		Duel.Destroy(tc,REASON_EFFECT)
		local g=Duel.GetMatchingGroup(c511001250.filter,tp,LOCATION_MZONE,0,nil)
		local c=e:GetHandler()
		local tc2=g:GetFirst()
		while tc2 do
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetValue(500)
			tc2:RegisterEffect(e1)
			tc2=g:GetNext()
		end
	end
end
