--真紅眼の凶雷皇ーエビル・デーモン
function c5636.initial_effect(c)
	aux.EnableDualAttribute(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5636,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(aux.IsDualState)
	e1:SetTarget(c5636.destg)
	e1:SetOperation(c5636.desop)
	c:RegisterEffect(e1)
end
function c5636.filter(c,atk)
	return c:IsFaceup() and c:IsDestructable() and c:GetDefence()<atk
end
function c5636.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c5636.filter,tp,0,LOCATION_MZONE,1,nil,c:GetAttack()) end
end
function c5636.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local dg=Duel.GetMatchingGroup(c5636.filter,tp,0,LOCATION_MZONE,nil,c:GetAttack())
	Duel.Destroy(dg,REASON_EFFECT)
end
