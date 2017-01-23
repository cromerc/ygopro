--Numbers Impact
function c511002151.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511002151.condition)
	e1:SetTarget(c511002151.target)
	e1:SetOperation(c511002151.activate)
	c:RegisterEffect(e1)
end
function c511002151.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if a:IsControler(1-tp) then
		a,d=d,a
	end
	return d and a:IsControler(tp) and a:IsSetCard(0x48) and d:IsControler(1-tp) and a:GetAttack()+1000<=d:GetAttack()
end
function c511002151.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	if a:IsControler(1-tp) then
		a,d=d,a
	end
	if chkc then return chkc==a end
	if chk==0 then return a:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(a)
end
function c511002151.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local bc=tc:GetBattleTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() and bc:IsRelateToBattle() and bc:IsControler(1-tp) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(bc:GetAttack())
		tc:RegisterEffect(e1)
	end
end
