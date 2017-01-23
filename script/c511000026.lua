--Jester Queen
function c511000026.initial_effect(c)
	--Destroy Spell and Trap
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000026,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511000026.sttg)
	e1:SetOperation(c511000026.stop)
	c:RegisterEffect(e1)
	--Mulitple Attacks
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EXTRA_ATTACK)
	e2:SetValue(c511000026.value)
	c:RegisterEffect(e2)
end
function c511000026.stfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()  
end
function c511000026.sttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c511000026.stfilter,tp,LOCATION_ONFIELD,0,1,c) end
	local sg=Duel.GetMatchingGroup(c511000026.stfilter,tp,LOCATION_ONFIELD,0,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511000026.stop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511000026.filter,tp,LOCATION_ONFIELD,0,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end
function c511000026.value(e,c)
	return Duel.GetMatchingGroupCount(Card.IsType,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,nil,TYPE_SPELL+TYPE_TRAP)
end