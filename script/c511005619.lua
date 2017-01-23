--Flame reaper (DOR)
--scripted by GameMaster (GM)
function c511005619.initial_effect(c)	
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetTarget(c511005619.target)
	e1:SetCondition(c511005619.condition)
	e1:SetOperation(c511005619.operation)
	c:RegisterEffect(e1)
end
function c511005619.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end

function c511005619.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end

function c511005619.cfilter(c)
	return c:IsFaceup() and c:IsCode(86318356)
end
function c511005619.condition(e,tp,eg,ep,ev,re,r,rp)
return Duel.IsExistingMatchingCard(c511005619.cfilter,tp,LOCATION_ONFIELD,0,1,nil) 
end
