--Tragic Comedy
function c511002199.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetCondition(c511002199.damcon)
	e3:SetTarget(c511002199.damtg)
	e3:SetOperation(c511002199.damop)
	c:RegisterEffect(e3)
end
function c511002199.damcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and a:IsRelateToBattle() and d:IsRelateToBattle() and not a:IsStatus(STATUS_BATTLE_DESTROYED) 
		and not d:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c511002199.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Group.FromCards(Duel.GetAttacker(),Duel.GetAttackTarget())
	if chk==0 then return g:IsExists(Card.IsControler,1,nil,1-tp) end
	local dg=g:Filter(Card.IsControler,nil,1-tp)
	local atk=dg:GetSum(Card.GetAttack)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c511002199.damop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d or not a:IsRelateToBattle() or not d:IsRelateToBattle() or a:IsStatus(STATUS_BATTLE_DESTROYED) 
		or d:IsStatus(STATUS_BATTLE_DESTROYED) then return end
	local g=Group.FromCards(a,d)
	local dg=g:Filter(Card.IsControler,nil,1-tp)
	local atk=dg:GetSum(Card.GetAttack)
	Duel.Damage(1-tp,atk,REASON_EFFECT)
end
