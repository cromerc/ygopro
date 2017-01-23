--Enigma the Creator
function c511002694.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(31986288,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511002694.condition)
	e1:SetTarget(c511002694.target)
	e1:SetOperation(c511002694.operation)
	c:RegisterEffect(e1)
end
function c511002694.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE)
end
function c511002694.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511002694.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511002695,0,0x4011,1200,1200,4,RACE_WARRIOR,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,511002695)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
