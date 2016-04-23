--化け猫
function c100000177.initial_effect(c)
	--destrroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000177,0))
	e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c29146185.retcon)
	e2:SetTarget(c100000177.destg)
	e2:SetOperation(c100000177.desop)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100000177,1))
	e3:SetCategory(CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c100000177.target)
	e3:SetOperation(c100000177.operation)
	c:RegisterEffect(e3)
end
function c29146185.retcon(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return rc:IsCode(100000170)
end
function c100000177.defilter(c)
	return c:IsLevelBelow(4) and c:IsDestructable()
end
function c100000177.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c100000177.defilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c100000177.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c100000177.defilter,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
	Duel.Damage(1-tp,g:GetCount()*800,REASON_EFFECT)
end
function c100000177.filter(c)
	return c:IsSetCard(0x305) and c:IsAbleToHand()
end
function c100000177.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000177.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c100000177.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectMatchingCard(tp,c100000177.filter,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	Duel.SendtoHand(g,nil,REASON_EFFECT)	
	Duel.ShuffleDeck(tp)	
end
