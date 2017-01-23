-- Forceful Deal
-- scripted by: UnknownGuest
function c800000000.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c800000000.condition)
	e1:SetTarget(c800000000.target)
	e1:SetOperation(c800000000.activate)
	e1:SetCost(c800000000.cost)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c800000000.cfilter(c,tp)
	return c:GetSummonPlayer()==1-tp
end
function c800000000.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c800000000.cfilter,1,nil,tp)
end
function c800000000.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end

function c800000000.confilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsControlerCanBeChanged()
end

function c800000000.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c800000000.confilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,nil,1,1-tp,LOCATION_MZONE)
end
function c800000000.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectMatchingCard(tp,c800000000.confilter,tp,0,LOCATION_MZONE,ft,ft,nil)
	local tc=g:GetFirst()
	while tc do
		Duel.GetControl(tc,tp)
		tc=g:GetNext()
	end
end