--磁石の大猿Ｅ
function c450000352.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(450000352,1))
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_DESTROY)
	e1:SetCondition(c450000352.atkcon)
	e1:SetTarget(c450000352.atktg)
	e1:SetOperation(c450000352.atkop)
	c:RegisterEffect(e1)
end
function c450000352.filter(c)
	return c:IsFaceup() and c:IsLocation(LOCATION_MZONE)
		and c:IsSetCard(0x4721)
end
function c450000352.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c450000352.filter,1,nil)
end
function c450000352.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
end
function c450000352.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(400)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
