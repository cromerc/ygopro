--Jurassic Impact
function c513000091.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c513000091.condition)
	e1:SetTarget(c513000091.target)
	e1:SetOperation(c513000091.activate)
	c:RegisterEffect(e1)
end
function c513000091.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<Duel.GetLP(1-tp)
end
function c513000091.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g1=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	local sg=g1:Clone()
	sg:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,g1:GetCount()*1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g2:GetCount()*1000)
end
function c513000091.filter(c,tp)
	return not c:IsLocation(LOCATION_MZONE) and c:IsControler(tp)
end
function c513000091.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
	local ct1=g:FilterCount(c513000091.filter,nil,tp)
	local ct2=g:FilterCount(c513000091.filter,nil,1-tp)
	Duel.BreakEffect()
	Duel.Damage(tp,ct1*1000,REASON_EFFECT)
	Duel.Damage(1-tp,ct2*1000,REASON_EFFECT)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	if Duel.GetTurnPlayer()~=tp then
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	else
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1)
	end
	e1:SetTargetRange(1,1)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	Duel.RegisterEffect(e2,tp)
end
