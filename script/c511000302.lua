--Magnet Force
function c511000302.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511000302.con)
	e1:SetTarget(c511000302.tg)
	e1:SetOperation(c511000302.operation)
	c:RegisterEffect(e1)
end
function c511000302.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g:GetFirst():IsRelateToEffect(e) then
		Duel.ChangeTargetCard(ev,g)
	end
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511000302.con)
	e1:SetTarget(c511000302.tg)
	e1:SetOperation(c511000302.op)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511000302.con(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasType(EFFECT_TYPE_ACTIVATE) or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return (tc:IsRace(RACE_ROCK) or tc:IsRace(RACE_MACHINE)) and tc:IsControler(e:GetHandler():GetControler()) and tc:IsLocation(LOCATION_MZONE)
end
function c511000302.filter2(c,re,rp,tf,ceg,cep,cev,cre,cr,crp)
	return tf(re,rp,ceg,cep,cev,cre,cr,crp,0,c)
end
function c511000302.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tf=re:GetTarget()
	local res,ceg,cep,cev,cre,cr,crp=Duel.CheckEvent(re:GetCode(),true)
	if chkc then return chkc~=e:GetLabelObject() and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and tf(re,rp,ceg,cep,cev,cre,cr,crp,0,chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000302.filter2,tp,0,LOCATION_MZONE,1,e:GetLabelObject(),re,rp,tf,ceg,cep,cev,cre,cr,crp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511000302.filter2,tp,0,LOCATION_MZONE,1,1,e:GetLabelObject(),re,rp,tf,ceg,cep,cev,cre,cr,crp)
end
function c511000302.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g:GetFirst():IsRelateToEffect(e) then
		Duel.ChangeTargetCard(ev,g)
	end
end
