--ネオス・スパイラル・フォース
function c100000102.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000102.condition)
	e1:SetCost(c100000102.cost)
	e1:SetTarget(c100000102.target)
	e1:SetOperation(c100000102.activate)
	c:RegisterEffect(e1)
end
function c100000102.cfilter(c)
	return c:IsFaceup() and c:IsCode(89943723) and c:GetAttackedCount()==0
	and not Duel.IsExistingMatchingCard(c100000102.cfilter2,tp,LOCATION_MZONE,0,1,nil)
end
function c100000102.cfilter2(c)
	return c:IsFaceup() and c:IsCode(89943723) and c:GetAttackedCount()~=0
end
function c100000102.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000102.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c100000102.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,100000102)==0 end
	Duel.RegisterFlagEffect(tp,100000102,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c100000102.filter(c)
	return c:IsFaceup() and not c:IsCode(89943723)
end
function c100000102.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000102.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000102.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c100000102.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c100000102.cfil(c)
	return c:IsFaceup() and c:IsCode(89943723)
end
function c100000102.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(tc:GetAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetProperty(EFFECT_FLAG_OATH)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetTarget(c100000102.cfil)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
end
