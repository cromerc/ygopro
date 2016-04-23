--カオス・ブルーム
function c500314601.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c500314601.target)
	e1:SetOperation(c500314601.activate)
	c:RegisterEffect(e1)
end
function c500314601.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c500314601.dfilter1(c,e)
	return c:IsFaceup() and c:IsAttackBelow(1000)
end
function c500314601.activate(e,tp,eg,ep,ev,re,r,rp)
	local cb=Duel.GetMatchingGroupCount(Card.IsCode,p,LOCATION_GRAVE,0,nil,500314601)
	if cb==0  then 
	local tc=Duel.SelectMatchingCard(tp,c500314601.dfilter1,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.Destroy(tc,REASON_EFFECT)
	elseif cb==1 then
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_SZONE,LOCATION_SZONE,e:GetHandler())
	if g:GetCount()<1 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=g:Select(tp,1,1,nil)
		Duel.Destroy(dg,REASON_EFFECT)
	elseif cb>=2  then
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	if g:GetCount()<1 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local dg=g:Select(tp,1,1,nil)
		Duel.Destroy(dg,REASON_EFFECT)
	end
end
