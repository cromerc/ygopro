--女教皇の錫杖
function c100000021.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c100000021.condition)
	e1:SetTarget(c100000021.target)
	e1:SetOperation(c100000021.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c100000021.handcon)
	c:RegisterEffect(e2)
end
function c100000021.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c100000021.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c100000021.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		Duel.BreakEffect()
		Duel.Damage(1-tp,500,REASON_EFFECT)
	end
end
function c100000021.handcon(e)
	return Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_MZONE,0)==0
end
