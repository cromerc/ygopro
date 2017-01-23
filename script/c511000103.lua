--Tomato Paradise
function c511000103.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_PLANT))
	e2:SetValue(c511000103.val)
	c:RegisterEffect(e2)
	--token
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000103,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetCondition(c511000103.tkcon)
	e3:SetTarget(c511000103.tktg)
	e3:SetOperation(c511000103.tkop)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e4)
	local e5=e3:Clone()
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e5)
end
function c511000103.ctfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c511000103.val(e,c)
	return Duel.GetMatchingGroupCount(c511000103.ctfilter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end
function c511000103.cfilter(c,tp)
	return c:IsFaceup() and c:IsRace(RACE_PLANT) and c:IsPreviousLocation(LOCATION_HAND) and c:GetSummonPlayer()==tp and c:IsControler(tp)
end
function c511000103.tkcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000103.cfilter,1,nil,tp) and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511000103.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
    if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000104,0,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511000103.tkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000104,0,0x4011,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH) then
		local token=Duel.CreateToken(tp,511000104)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	end
end
