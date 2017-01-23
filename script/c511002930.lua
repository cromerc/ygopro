--Guard Plus
function c511002930.initial_effect(c)
	-- recover
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511002930.cost)
	e1:SetTarget(c511002930.target)
	e1:SetOperation(c511002930.activate)
	c:RegisterEffect(e1)
end
function c511002930.cfilter(c,tp)
	return c:GetAttack()>0 and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,0,1,c)
end
function c511002930.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511002930.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.CheckReleaseGroup(tp,c511002930.cfilter,1,nil,tp) end
	local tc=Duel.SelectReleaseGroup(tp,c511002930.cfilter,1,1,nil,tp):GetFirst()
	local atk=tc:GetAttack()
	Duel.Release(tc,REASON_COST)
	Duel.SetTargetParam(atk)
end
function c511002930.activate(e,tp,eg,ep,ev,re,r,rp)
	local atk=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(atk)
		tc:RegisterEffect(e1)
	end
end
