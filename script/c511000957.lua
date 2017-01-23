--Dark the Hidden Knight
function c511000957.initial_effect(c)
	--direct attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e1)
	--change pos
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000957,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511000957.cost)
	e2:SetTarget(c511000957.target)
	e2:SetOperation(c511000957.operation)
	c:RegisterEffect(e2)
end
function c511000957.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511000957.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return d:IsDefensePos() and d:IsControler(tp) end
	Duel.SetTargetCard(d)
end
function c511000957.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsDefensePos() then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,0,POS_FACEUP_ATTACK,0)
		Duel.ChangeAttackTarget(tc)
	end
end
