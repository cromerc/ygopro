--Performapal Sky Ring
function c511009403.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c511009403.condition)
	e1:SetTarget(c511009403.target)
	e1:SetOperation(c511009403.operation)
	c:RegisterEffect(e1)
end
function c511009403.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f) and c:IsRace(RACE_SPELLCASTER) 
end
function c511009403.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsExistingMatchingCard(c511009403.filter,tp,LOCATION_MZONE,0,1,nil) then return false end
	if tp==ep or not Duel.IsChainNegatable(ev) then return false end
	if not re:IsActiveType(TYPE_MONSTER) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc>0
end
function c511009403.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c511009403.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
end
