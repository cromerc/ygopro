--Card of Endurance
function c511001280.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetCondition(c511001280.con)
	e1:SetTarget(c511001280.tg)
	e1:SetOperation(c511001280.op)
	c:RegisterEffect(e1)
end
function c511001280.con(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return ep==tp and (tp==rp or (at and at:IsControler(tp)))
end
function c511001280.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,1000)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511001280.op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
	Duel.Draw(p,1,REASON_EFFECT)
end
