--縛られし神への祭壇
function c100000432.initial_effect(c)
	c:EnableCounterPermit(0x94)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COUNTER)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1)
	e2:SetCondition(c100000432.condition)
	e2:SetOperation(c100000432.ctop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c100000432.cost)
	e3:SetTarget(c100000432.target)
	e3:SetOperation(c100000432.op)
	c:RegisterEffect(e3)
end
function c100000432.condition(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.GetTurnPlayer()==tp
end
function c100000432.ctop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroupCount(Card.IsPosition,tp,LOCATION_MZONE,LOCATION_MZONE,nil,POS_FACEUP_DEFENSE)
	e:GetHandler():AddCounter(0x94,sg)
end
function c100000432.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() and e:GetHandler():GetCounter(0x94)>3 end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c100000432.filter(c,e,tp)
	return c:IsSetCard(0x21) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000432.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000432.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c100000432.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c100000432.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
