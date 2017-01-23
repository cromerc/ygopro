--No.64 古狸三太夫
function c511010064.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_BEAST),2,2)
	c:EnableReviveLimit()
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39972129,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511010064.spcost)
	e1:SetTarget(c511010064.sptg)
	e1:SetOperation(c511010064.spop)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetCondition(c511010064.indcon)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c511010064.indes)
	c:RegisterEffect(e3)
	if not c511010064.global_check then
		c511010064.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010064.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010064.xyz_number=64
function c511010064.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010064.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,39972130,0,0x4011,-2,0,1,RACE_BEAST,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511010064.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,39972130,0,0x4011,-2,0,1,RACE_BEAST,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,39972130)
	Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	local g,atk=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil):GetMaxGroup(Card.GetAttack)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	token:RegisterEffect(e1)
	Duel.SpecialSummonComplete()
end
function c511010064.ifilter(c)
	return c:IsFaceup() and c:Code(39972130)
end
function c511010064.indcon(e)
	return Duel.IsExistingMatchingCard(c511010064.ifilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
function c511010064.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,39972129)
	Duel.CreateToken(1-tp,39972129)
end
function c511010064.indes(e,c)
return not c:IsSetCard(0x48)
end