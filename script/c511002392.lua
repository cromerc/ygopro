--Leaf of the Transforming Tanuki
function c511002392.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511002392.condition)
	e1:SetTarget(c511002392.target)
	e1:SetOperation(c511002392.operation)
	c:RegisterEffect(e1)
end
function c511002392.cfilter(c)
	return c:IsOnField() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511002392.condition(e,tp,eg,ep,ev,re,r,rp)
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	if tg==nil then return false end
	local g=tg:Filter(c511002392.cfilter,nil)
	g:KeepAlive()
	e:SetLabelObject(g)
	return ex and tc+g:GetCount()-tg:GetCount()==1
end
function c511002392.filter(c,card)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable() and c~=card
end
function c511002392.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	local g=e:GetLabelObject()
	if chk==0 then return g and Duel.IsExistingMatchingCard(c511002392.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,g:GetFirst(),e:GetHandler()) end
	Duel.SetTargetCard(g)
	local dg=Duel.GetMatchingGroup(c511002392.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,g:GetFirst(),e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,1,0,0)
end
function c511002392.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e1:SetValue(1)
		e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e1:SetReset(RESET_CHAIN)
		tc:RegisterEffect(e1)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=Duel.SelectMatchingCard(tp,c511002392.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,tc,e:GetHandler())
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
