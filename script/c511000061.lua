--Gjallarhorn
function c511000061.initial_effect(c)
	--Return
	local e2=Effect.CreateEffect(c)
	--e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c511000061.rtg)
	e2:SetOperation(c511000061.rop)
	c:RegisterEffect(e2)
end
function c511000061.rfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x4B)
end
function c511000061.rtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000061.rfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.IsExistingTarget(c511000061.rfilter,tp,LOCATION_MZONE,0,1,nil) end
	--e:SetType(EFFECT_TYPE_ACTIVATE)
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000061.rfilter,tp,LOCATION_MZONE,0,1,1,nil)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_END)
	e1:SetLabelObject(e)
	e1:SetOperation(c511000061.resetop)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
	c:SetTurnCounter(0)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetLabel(3)
	e2:SetCountLimit(1)
	e2:SetCondition(c511000061.remcon)
	e2:SetOperation(c511000061.remop)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN,3)
	c:RegisterEffect(e2)
	e:GetHandler():RegisterFlagEffect(1082946,RESET_PHASE+PHASE_END+RESET_SELF_TURN,0,3)
	c511000061[c]=e2
end
function c511000061.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP)
end
function c511000061.rop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EFFECT_IMMUNE_EFFECT)
		e3:SetValue(c511000061.efilter)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
	end
end
function c511000061.resetop(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetType(EFFECT_TYPE_QUICK_O)
end
function c511000061.remcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511000061.remop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetTurnCounter()
	ct=ct+1
	c:SetTurnCounter(ct)
	if ct==3 then
		local e2=Effect.CreateEffect(c)
		e2:SetCategory(CATEGORY_DAMAGE+CATEGORY_REMOVE)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e2:SetCode(511000061)
		e2:SetCountLimit(1)
		e2:SetTarget(c511000061.damtg)
		e2:SetOperation(c511000061.damop)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END+RESET_SELF_TURN)
		c:RegisterEffect(e2)
		c:ResetFlagEffect(1082946)
		Duel.RaiseSingleEvent(c,511000061,e,r,rp,ep,0)
	end
end
function c511000061.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
	g=g:Filter(Card.IsFaceup,nil)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetSum(Card.GetAttack))
end
function c511000061.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_MZONE,0,nil)
	local g2=g:Filter(Card.IsFaceup,nil)
	local sum=g2:GetSum(Card.GetAttack)
	Duel.Damage(1-tp,sum,REASON_EFFECT)
	g:AddCard(c)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)	
end
