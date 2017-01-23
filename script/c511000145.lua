--Infernity Zero
function c511000145.initial_effect(c)
	c:EnableReviveLimit()
	--Survival
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_HAND)
	e1:SetCost(c511000145.cost)
	e1:SetCondition(c511000145.condition)
	e1:SetTarget(c511000145.target)
	e1:SetOperation(c511000145.operation)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_LOSE_LP)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,0)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--cannot destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511000145.ncon)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--self destroy
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_SELF_DESTROY)
	e6:SetCondition(c511000145.sdcon)
	c:RegisterEffect(e6)
	--counter
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_DAMAGE)
	e4:SetCondition(c511000145.ctcon)
	e4:SetOperation(c511000145.ctop)
	c:RegisterEffect(e4)
end
function c511000145.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
		g:RemoveCard(e:GetHandler())
		return g:GetCount()>0 and g:FilterCount(Card.IsDiscardable,nil)==g:GetCount()
	end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	g:RemoveCard(e:GetHandler())
	Duel.SendtoGrave(g,REASON_COST+REASON_DISCARD)
	e:SetLabel(g:GetCount())
end
function c511000145.condition(e,tp,eg,ep,ev,re,r,rp)
	if rp==tp or Duel.GetLP(tp)>2000 then return false end
	return aux.damcon1(e,tp,eg,ep,ev,re,r,rp)
end
function c511000145.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511000145.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)~=0 then
		c:CompleteProcedure()
	end
end
function c511000145.ncon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)==0
end
function c511000145.sdcon(e)
	return e:GetHandler():GetCounter(0x1097)>=3
end
function c511000145.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511000145.ctop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x1097,1)
end
