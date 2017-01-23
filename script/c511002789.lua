--Wild Charger
function c511002789.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511002789.condition)
	e1:SetTarget(c511002789.target)
	e1:SetOperation(c511002789.activate)
	c:RegisterEffect(e1)
end
function c511002789.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and d:IsFaceup() and d:IsType(TYPE_XYZ) and d:GetOverlayCount()==0 and d:IsControler(tp) 
		and a:IsControler(1-tp)
end
function c511002789.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local d=Duel.GetAttackTarget()
	if chkc then return d==chkc end
	if chk==0 then return d:IsOnField() and d:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(d)
end
function c511002789.activate(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local tc=Duel.GetFirstTarget()
	if a and a:IsRelateToBattle() and tc and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(a:GetAttack())
		tc:RegisterEffect(e1)
	end
end
