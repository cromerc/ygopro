--Cipher Diffusion
function c511009093.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009093.target)
	e1:SetOperation(c511009093.activate)
	c:RegisterEffect(e1)
end
function c511009093.filter1(c)
	return c:IsFaceup() and c:GetAttack()>=3000 and c:IsSetCard(0xe5) 
end
function c511009093.filter2(c)
	return c:IsFaceup() and c:IsSetCard(0xe5) 
end
function c511009093.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511009093.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c511009093.filter1,tp,LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(52128900,0))
	local g1=Duel.SelectTarget(tp,c511009093.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(52128900,1))
	local g2=Duel.SelectTarget(tp,c511009093.filter2,tp,LOCATION_MZONE,0,1,1,g1:GetFirst())
	e:SetLabelObject(g1:GetFirst())
	
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetProperty(EFFECT_FLAG_OATH)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c511009093.ftarget)
	e2:SetLabel(g2:GetFirst():GetFieldID())
	e2:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e2,tp)
end
function c511009093.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc1=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc2=g:GetFirst()
	if tc1==tc2 then tc2=g:GetNext() end
	if tc1:IsRelateToEffect(e) and tc1:IsFaceup() and tc2:IsRelateToEffect(e) and tc2:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc2:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_ATTACK_FINAL)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetValue(0)
		tc1:RegisterEffect(e2)
	end
end
function c511009093.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end