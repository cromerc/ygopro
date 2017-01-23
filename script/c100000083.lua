--幻魔の扉 
function c100000083.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000083.target)
	e1:SetOperation(c100000083.activate)
	c:RegisterEffect(e1)
end
function c100000083.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000083.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c100000083.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
	Duel.BreakEffect()
	local g=Duel.GetMatchingGroup(c100000083.filter,tp,0,LOCATION_GRAVE,nil,e,tp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local spg=g:Select(tp,1,1,nil)
		Duel.SpecialSummon(spg,0,tp,tp,true,false,POS_FACEUP)
	end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetOperation(c100000083.thop)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,1)
	Duel.RegisterEffect(e1,tp)
end
function c100000083.thop(e,tp,eg,ep,ev,re,r,rp)
	local p=e:GetHandlerPlayer()
	Duel.SetLP(tp,Duel.GetLP(p)/10,REASON_EFFECT)
end
