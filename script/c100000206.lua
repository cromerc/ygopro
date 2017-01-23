--ギミック・パペット－スケアクロウ
function c100000206.initial_effect(c)
	--target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetTarget(c100000206.tglimit)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--to defence
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100000206,0))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetCondition(c100000206.poscon)
	e3:SetOperation(c100000206.posop)
	c:RegisterEffect(e3)
end
function c100000206.tglimit(e,c)
	return c~=e:GetHandler()
end
function c100000206.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c100000206.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end