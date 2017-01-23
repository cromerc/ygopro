--Hero Solidarity
function c511002361.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511002361.cost)
	e1:SetTarget(c511002361.target)
	e1:SetOperation(c511002361.activate)
	c:RegisterEffect(e1)
end
function c511002361.costfilter(c)
	return c:IsSetCard(0x3008) and c:IsAbleToRemoveAsCost()
end
function c511002361.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c511002361.filter,tp,0,LOCATION_ONFIELD,nil)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002361.costfilter,tp,LOCATION_GRAVE,0,1,nil) 
		and ct>0 end
	if ct>2 then ct=2 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511002361.costfilter,tp,LOCATION_GRAVE,0,1,ct,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	e:SetLabel(g:GetCount())
end
function c511002361.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c511002361.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c511002361.filter,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,e:GetLabel(),0,0)
end
function c511002361.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	local g=Duel.GetMatchingGroup(c511002361.filter,tp,0,LOCATION_ONFIELD,nil)
	if g:GetCount()<ct then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local sg=g:Select(tp,ct,ct,nil)
	Duel.HintSelection(sg)
	Duel.Destroy(sg,REASON_EFFECT)
end
