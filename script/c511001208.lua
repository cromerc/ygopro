--Multiple Slime
function c511001208.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001208,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511001208.condition)
	e1:SetTarget(c511001208.target)
	e1:SetOperation(c511001208.operation)
	c:RegisterEffect(e1)
end
function c511001208.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c511001208.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,3,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,0,0)
end
function c511001208.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<3 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,21770261,0x13d,0x13d,0,0,3,RACE_AQUA,ATTRIBUTE_WATER) then return end
	for i=1,3 do
		local token=Duel.CreateToken(tp,21770261)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
	Duel.SpecialSummonComplete()
end
