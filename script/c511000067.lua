--Endless Loan
function c511000067.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000067,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c511000067.condition)
	e2:SetTarget(c511000067.sptg)
	e2:SetOperation(c511000067.spop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000067,1))
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCondition(c511000067.descon)
	e4:SetCost(c511000067.descost)
	e4:SetTarget(c511000067.destg)
	e4:SetOperation(c511000067.desop)
	c:RegisterEffect(e4)
end
function c511000067.condition(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return ep~=tp and ec:GetCode()~=511000068
end
function c511000067.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
	and Duel.IsPlayerCanSpecialSummonMonster(tp,511000068,0,0x4011,0,0,1,RACE_ROCK,ATTRIBUTE_LIGHT) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511000067.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000068,0,0x4011,0,0,1,RACE_ROCK,ATTRIBUTE_LIGHT) then
		local token=Duel.CreateToken(tp,511000068)
		Duel.SpecialSummonStep(token,0x20,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1,true)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UNRELEASABLE_SUM)
		token:RegisterEffect(e2,true)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetValue(1)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e3,true)
	end
	Duel.SpecialSummonComplete()
end
function c511000067.descon(e,tp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=e:GetHandler():GetControler() and tp~=e:GetHandler():GetControler() and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2)
end
function c511000067.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToGraveAsCost,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsAbleToGraveAsCost,1,1,REASON_COST)
end
function c511000067.desfilter(c)
	return c:IsCode(511000068) and c:IsDestructable()
end
function c511000067.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE)  and chkc:IsOnField() and c511000001.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000067.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511000067.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511000067.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
