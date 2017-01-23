--Tuner's Reflect
function c511000898.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x11e8)
	e1:SetTarget(c511000898.target)
	e1:SetOperation(c511000898.activate)
	c:RegisterEffect(e1)
end
function c511000898.filter(c,e,tp,tid)
	return bit.band(c:GetReason(),REASON_DESTROY)==REASON_DESTROY and c:GetTurnID()==tid and c:IsType(TYPE_TUNER) 
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:IsPreviousPosition(POS_FACEUP)
end
function c511000898.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tid=Duel.GetTurnCount()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingMatchingCard(c511000898.filter,tp,LOCATION_GRAVE,0,2,nil,e,tp,tid) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c511000898.activate(e,tp,eg,ep,ev,re,r,rp)
	local tid=Duel.GetTurnCount()
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000898.filter,tp,LOCATION_GRAVE,0,2,2,nil,e,tp,tid)
	if g:GetCount()>0 and Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_ATTACK)>1 then
		local sum=g:GetSum(Card.GetAttack)
		Duel.Damage(1-tp,sum,REASON_EFFECT)
	end
end
