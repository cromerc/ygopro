--Demise Urban
function c511009094.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--negate attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(22991179,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(c511009094.condition)
	e2:SetCountLimit(1)
	e2:SetTarget(c511009094.target)
	e2:SetOperation(c511009094.activate)
	c:RegisterEffect(e2)
end
function c511009094.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511009094.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xc008)
end
function c511009094.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511009094.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009094.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009094.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511009094.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(100)
		tc:RegisterEffect(e1)
	end
end
