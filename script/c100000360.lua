--シャイニング・ボンバー
function c100000360.initial_effect(c)
	--battle destroyed
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000360,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c100000360.condition)
	e1:SetTarget(c100000360.target)
	e1:SetOperation(c100000360.operation)
	c:RegisterEffect(e1)
end
function c100000360.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler() and e:GetHandler():IsReason(REASON_BATTLE)
end
function c100000360.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,800)
end
function c100000360.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,800,REASON_EFFECT,true)
	Duel.Damage(1-tp,800,REASON_EFFECT,true)
	Duel.RDComplete()
end
