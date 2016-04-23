--Five Star Twilight
function c511000148.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000148,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCondition(c511000148.condition)	
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000148.cost)
	e1:SetTarget(c511000148.sptg)
	e1:SetOperation(c511000148.spop)
	c:RegisterEffect(e1)
end

function c511000148.confilter(c)
	return c:IsCode(40640057)
end
function c511000148.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)==1
		and Duel.IsExistingMatchingCard(c511000148.confilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_GRAVE,0,1,nil)
end

function c511000148.cfilter(c)
	return c:GetLevel()==5
end
function c511000148.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511000148.cfilter,1,nil) end
	local rg=Duel.SelectReleaseGroup(tp,c511000148.cfilter,1,1,nil)
	Duel.Release(rg,REASON_COST)
end

function c511000148.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,4,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,4,0,0)
end
function c511000148.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,511000151,0,0x4011,300,200,1,RACE_FIEND,ATTRIBUTE_DARK) then
		local token=Duel.CreateToken(tp,511000151)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetDescription(aux.Stringid(511000148,0))
		e1:SetType(EFFECT_TYPE_QUICK_O)
		e1:SetCode(EVENT_BE_BATTLE_TARGET)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCondition(c511000148.ncondition)
		e1:SetOperation(c511000148.noperation)
		e1:SetCountLimit(1)
		token:RegisterEffect(e1)
		local e01=Effect.CreateEffect(e:GetHandler())
		e01:SetType(EFFECT_TYPE_SINGLE)
		e01:SetCode(EFFECT_UNRELEASEABLE_SUM)
		e01:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e01:SetValue(1)
		token:RegisterEffect(e01,true)		
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000152,0,0x4011,300,200,1,RACE_FIEND,ATTRIBUTE_DARK) then
		local token=Duel.CreateToken(tp,511000152)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UNRELEASEABLE_SUM)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetValue(1)
		token:RegisterEffect(e2,true)		
	end
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000154,0,0x4011,300,200,1,RACE_FIEND,ATTRIBUTE_DARK) then
		local token=Duel.CreateToken(tp,511000154)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		local e4=Effect.CreateEffect(e:GetHandler())
		e4:SetDescription(aux.Stringid(511000148,0))
		e4:SetCategory(CATEGORY_ATKCHANGE)
		e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e4:SetType(EFFECT_TYPE_IGNITION)
		e4:SetRange(LOCATION_MZONE)
		e4:SetCountLimit(1)
		e4:SetTarget(c511000148.target)
		e4:SetOperation(c511000148.operation)
		token:RegisterEffect(e4)
		local e04=Effect.CreateEffect(e:GetHandler())
		e04:SetType(EFFECT_TYPE_SINGLE)
		e04:SetCode(EFFECT_UNRELEASEABLE_SUM)
		e04:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e04:SetValue(1)
		token:RegisterEffect(e04,true)	
	end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000153,0,0x4011,300,200,1,RACE_FIEND,ATTRIBUTE_DARK) then
		local token=Duel.CreateToken(tp,511000153)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetDescription(aux.Stringid(511000148,0))
		e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e3:SetCode(EVENT_SPSUMMON_SUCCESS)
		e3:SetTarget(c511000148.sptg2)
		e3:SetOperation(c511000148.spop2)
		token:RegisterEffect(e3)
		local e03=Effect.CreateEffect(e:GetHandler())
		e03:SetType(EFFECT_TYPE_SINGLE)
		e03:SetCode(EFFECT_UNRELEASEABLE_SUM)
		e03:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e03:SetValue(1)
		token:RegisterEffect(e03,true)
	end

	Duel.SpecialSummonComplete()
end

function c511000148.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(1-tp) and chkc:IsFaceup() and chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end

function c511000148.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(tc:GetAttack()/2)
		tc:RegisterEffect(e1)
	end
end

function c511000148.ncondition(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()==tp and Duel.GetCurrentPhase()==PHASE_BATTLE then return end
	local ec=eg:GetFirst()
	return ec:IsFaceup() and ec:IsCode(511000151) or ec:IsCode(511000152) or ec:IsCode(511000153) or ec:IsCode(511000154) or ec:IsCode(40640057)
end

function c511000148.noperation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end

function c511000148.spfilter(c,e,tp)
	return c:IsCode(40640057) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end

function c511000148.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000148.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE)
end
function c511000148.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000148.spfilter,tp,LOCATION_HAND+LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g:GetFirst()
	if tc then
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
		tc:CompleteProcedure()
	end
end