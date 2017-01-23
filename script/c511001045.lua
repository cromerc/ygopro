--Gamusharush
function c511001045.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511001045.condition)
	e1:SetTarget(c511001045.target)
	e1:SetOperation(c511001045.activate)
	c:RegisterEffect(e1)
end
function c511001045.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,600)
end
function c511001045.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local at=Duel.GetAttackTarget()
	if not at or tc:IsFacedown() or at:IsFacedown() then return false end
	if tc:IsControler(1-tp) then tc=at end
	e:SetLabelObject(tc)
	return tc:IsControler(tp) and tc:IsLocation(LOCATION_MZONE) and tc:GetAttack()>0
end
function c511001045.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		if tc:RegisterEffect(e1) then
			Duel.Damage(1-tp,600,REASON_EFFECT)
		end
	end
end
