--Ｓｐ－ラピッド・ショットウィング
function c100100101.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100100101.con)
	e1:SetTarget(c100100101.target)
	e1:SetOperation(c100100101.activate)
	c:RegisterEffect(e1)
end
function c100100101.con(e,tp,eg,ep,ev,re,r,rp)
	local td=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return tc and td:GetCounter(0x91)>2
end
function c100100101.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	return true
end
function c100100101.activate(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,0,nil)		
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tdg=dg:Select(tp,1,1,nil)
	local tc=tdg:GetFirst()	
	local td=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(td:GetCounter(0x91)*200)
		tc:RegisterEffect(e1)
	end
end
