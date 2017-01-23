--Infinity
function c95000004.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c95000004.condition)
	e1:SetTarget(c95000004.target)
	e1:SetOperation(c95000004.operation)
	c:RegisterEffect(e1)
end
c95000004.mark=0
function c95000004.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(95000005)>0
end
function c95000004.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetChainLimit(c95000004.climit)
end
function c95000004.climit(e,lp,tp)
	return lp==tp or not e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c95000004.filter(c,code)
    return c:GetCode()==code and c:IsFacedown() 
end
function c95000004.operation(e,tp,eg,ep,ev,re,r,rp)
	local g1=Duel.GetFirstMatchingCard(c95000004.filter,tp,LOCATION_SZONE,0,nil,95000006)
	local g2=Duel.GetFirstMatchingCard(c95000004.filter,tp,LOCATION_SZONE,0,nil,95000007)
	local g3=Duel.GetFirstMatchingCard(c95000004.filter,tp,LOCATION_SZONE,0,nil,95000008)
	if g1 then 
	Duel.ChangePosition(g1,POS_FACEUP)
	g1:SetStatus(STATUS_EFFECT_ENABLED,true)
	g1:SetStatus(STATUS_CHAINING,true)
	end
	if g2 then 
	Duel.ChangePosition(g2,POS_FACEUP)
	g2:SetStatus(STATUS_EFFECT_ENABLED,true)
	g2:SetStatus(STATUS_CHAINING,true)
	end
	if g3 then 
	Duel.ChangePosition(g3,POS_FACEUP)
	g3:SetStatus(STATUS_EFFECT_ENABLED,true)
	g3:SetStatus(STATUS_CHAINING,true)
	end
end
