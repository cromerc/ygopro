--Action Card - Guard Cover
function c95000154.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c95000154.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c95000154.handcon)
	c:RegisterEffect(e2)
end
function c95000154.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end
function c95000154.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c95000154.condition2)
	e1:SetTarget(c95000154.target2)
	e1:SetOperation(c95000154.activate2)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c95000154.condition2(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or not re:IsHasType(EFFECT_TYPE_ACTIVATE) or not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or g:GetCount()~=1 then return false end
	local tc=g:GetFirst()
	e:SetLabelObject(tc)
	return tc:IsControler(tp) and tc:IsLocation(LOCATION_MZONE)
end
function c95000154.filter2(c,re,rp,tf,ceg,cep,cev,cre,cr,crp)
	return tf(re,rp,ceg,cep,cev,cre,cr,crp,0,c)
end
function c95000154.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tf=re:GetTarget()
	local res,ceg,cep,cev,cre,cr,crp=Duel.CheckEvent(re:GetCode(),true)
	if chkc then return chkc~=e:GetLabelObject() and chkc:IsControler(tp) and tf(re,rp,ceg,cep,cev,cre,cr,crp,0,chkc) end
	if chk==0 then return Duel.IsExistingTarget(c95000154.filter2,tp,LOCATION_ONFIELD,0,1,e:GetLabelObject(),re,rp,tf,ceg,cep,cev,cre,cr,crp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c95000154.filter2,tp,LOCATION_ONFIELD,0,1,1,e:GetLabelObject(),re,rp,tf,ceg,cep,cev,cre,cr,crp)
end
function c95000154.activate2(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g:GetFirst():IsRelateToEffect(e) then
		if Duel.SelectYesNo(tp,aux.Stringid(95000154,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(95000154,1))
		Duel.ChangeTargetCard(ev,g)
		end
	end
end
