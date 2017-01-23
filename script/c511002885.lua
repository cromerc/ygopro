--Quiz Hour
function c511002885.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002885.target)
	e1:SetOperation(c511002885.activate)
	c:RegisterEffect(e1)
	--cannot release
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_CANNOT_RELEASE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	c:RegisterEffect(e2)
	--Destroy
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c511002885.descon)
	e3:SetTarget(c511002885.destg)
	e3:SetOperation(c511002885.desop)
	c:RegisterEffect(e3)
end
function c511002885.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511002885.setfilter(c,code,tp)
    return (c:IsMSetable(true,nil) or not Duel.IsPlayerAffectedByEffect(tp,EFFECT_CANNOT_MSET)) and c:IsCode(code)
end
function c511002885.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.Destroy(g,REASON_EFFECT)
	Duel.BreakEffect()
	local g1=Duel.GetMatchingGroup(c511002885.setfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,51102783,tp)
	local g2=Duel.GetMatchingGroup(c511002885.setfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,51102786,tp)
	local g3=Duel.GetMatchingGroup(c511002885.setfilter,tp,LOCATION_HAND+LOCATION_DECK,0,nil,51102781,tp)
	if g1:GetCount()>0 and g2:GetCount()>0 and g3:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINT_SET)
		local sg1=g1:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINT_SET)
		local sg2=g2:Select(tp,1,1,nil)
		sg1:Merge(sg2)
		Duel.Hint(HINT_SELECTMSG,tp,HINT_SET)
		local sg3=g3:Select(tp,1,1,nil)
		sg1:Merge(sg3)
		local tc=sg1:GetFirst()
		while tc do
			Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEDOWN_DEFENSE,true)
			Duel.RaiseEvent(tc,EVENT_MSET,e,REASON_EFFECT,tp,tp,0)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
			e2:SetRange(LOCATION_MZONE)
			e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e2)
			tc=sg1:GetNext()
		end
	end
end
function c511002885.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_DESTROY) 
end
function c511002885.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511002885.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
