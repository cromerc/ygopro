--Mantis Egg
function c511009032.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511009032.actcon)
	c:RegisterEffect(e1)
		--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1)
	-- e2:SetCondition(c511009032.spcon)
	e2:SetTarget(c511009032.sptg)
	e2:SetOperation(c511009032.spop)
	c:RegisterEffect(e2)
end
--Mantis collection
c511009032.collection={
[58818411]=true;[511002438]=true;[511002439]=true;[511009033]=true;
}
function c511009032.cfilter(c)
	return c:IsFaceup() and c511009032.collection[c:GetCode()]
end
function c511009032.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511009032.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511009032.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511009033,0,0x4011,0,0,1,RACE_INSECT,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511009032.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e)
		or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511009033,0,0x4011,0,0,1,RACE_INSECT,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,511009033)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
end