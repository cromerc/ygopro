--Warp Beam
function c511001913.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001913.target)
	e1:SetOperation(c511001913.activate)
	c:RegisterEffect(e1)
end
function c511001913.filter(c,e)
	return c:IsFaceup() and c:IsCanBeEffectTarget(e)
end
function c511001913.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then 
		local tg=Duel.GetMatchingGroup(c511001913.filter,tp,LOCATION_MZONE,0,e:GetHandler(),e)
		local sg=Duel.GetMatchingGroup(Card.IsAbleToGraveAsCost,tp,LOCATION_ONFIELD,0,e:GetHandler())
		if tg:GetCount()==sg:GetCount() then
			return tg:GetCount()>1
		else
			return sg:GetCount()>=tg:GetCount()
		end
	end
	local tg=Duel.GetMatchingGroup(c511001913.filter,tp,LOCATION_MZONE,0,e:GetHandler(),e)
	local sg=Duel.GetMatchingGroup(Card.IsAbleToGraveAsCost,tp,LOCATION_ONFIELD,0,e:GetHandler())
	tg:Merge(sg)
	local max=math.floor(tg:GetCount()/2)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,max,nil)
	sg:Sub(g)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	sg=sg:Select(tp,g:GetCount(),g:GetCount(),nil)
	Duel.SendtoGrave(sg,REASON_COST)
end
function c511001913.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(600)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DIRECT_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
