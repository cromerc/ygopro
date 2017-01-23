--Offensive Guard
function c511001525.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511001525.condition)
	e1:SetTarget(c511001525.target)
	e1:SetOperation(c511001525.activate)
	c:RegisterEffect(e1)
end
function c511001525.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetAttackTarget()==nil
end
function c511001525.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511001525.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetAttacker()
	if tg:IsFaceup() and tg:IsAttackable() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(tg:GetAttack()/2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tg:RegisterEffect(e1)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
