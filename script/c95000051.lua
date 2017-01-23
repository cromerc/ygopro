--Action Card - Mad Hurricane
function c95000051.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95000051.target)
	e1:SetOperation(c95000051.operation)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c95000051.handcon)
	c:RegisterEffect(e2)
end
function c95000051.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end
function c95000051.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)>0 end
	local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,0)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c95000051.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,0)
	Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
end



