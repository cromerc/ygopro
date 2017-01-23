--カオス・ブルーム
function c500314601.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c500314601.target)
	e1:SetOperation(c500314601.activate)
	c:RegisterEffect(e1)
end
function c500314601.filter1(c)
	return c:IsFaceup() and c:IsAttackBelow(1000) and c:IsDestructable()
end
function c500314601.filter2(c)
	return c:GetSequence()<5 and c:IsDestructable()
end
function c500314601.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_GRAVE,0,nil,500314601)
	local a= ct==0 and Duel.IsExistingMatchingCard(c500314601.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
	local b= ct==1 and Duel.IsExistingMatchingCard(c500314601.filter2,tp,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler())
	local c= ct>=2 and Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler())
	if chk==0 then return a or b or c end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
end
function c500314601.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_GRAVE,0,nil,500314601)
	local g=Group.CreateGroup()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	if ct==0 then 
		g=Duel.SelectMatchingCard(tp,c500314601.filter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	elseif ct==1 then
		g=Duel.SelectMatchingCard(tp,c500314601.filter2,tp,LOCATION_SZONE,LOCATION_SZONE,1,1,e:GetHandler())
	elseif ct>=2 then
		g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,e:GetHandler())
	end
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
