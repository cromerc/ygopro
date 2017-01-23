--Forced Change
function c511001740.initial_effect(c)
	--change target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511001740.condition)
	e1:SetTarget(c511001740.target)
	e1:SetOperation(c511001740.activate)
	c:RegisterEffect(e1)
end
function c511001740.filter(c,tp)
	return c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
end
function c511001740.condition(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g then return false end
	return g:IsExists(c511001740.filter,1,nil,tp)
end
function c511001740.filter2(c,re,rp,tf,ceg,cep,cev,cre,cr,crp,g)
	return tf(re,rp,ceg,cep,cev,cre,cr,crp,0,c) and not g:IsContains(c)
end
function c511001740.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g then return false end
	local tf=re:GetTarget()
	local res,ceg,cep,cev,cre,cr,crp=Duel.CheckEvent(re:GetCode(),true)
	if chkc then return chkc~=e:GetLabelObject() and chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and tf(re,rp,ceg,cep,cev,cre,cr,crp,0,chkc,g) end
	if chk==0 then return Duel.IsExistingTarget(c511001740.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,re,rp,tf,ceg,cep,cev,cre,cr,crp,g) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001740.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,re,rp,tf,ceg,cep,cev,cre,cr,crp,g)
end
function c511001740.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g and g:GetFirst():IsRelateToEffect(e) then
		Duel.ChangeTargetCard(ev,g)
	end
end
