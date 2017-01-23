--Cup of Sealed Soul
function c511001306.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--remain field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e2)
	--sp summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001306,0))
	e3:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511001306.spcon)
	e3:SetTarget(c511001306.sptg)
	e3:SetOperation(c511001306.spop)
	c:RegisterEffect(e3)
	--indestructable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_INDESTRUCTABLE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e4:SetCondition(c511001306.incon)
	e4:SetTarget(c511001306.infilter)
	c:RegisterEffect(e4)
end
function c511001306.cfilter(c,code)
	return c:IsFaceup() and c:IsCode(code)
end
function c511001306.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001306.cfilter,tp,LOCATION_SZONE,0,1,nil,511001305)
		and Duel.IsExistingMatchingCard(c511001306.cfilter,tp,LOCATION_SZONE,0,1,nil,29762407)
end
function c511001306.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,89194033,0,0x21,2500,2000,6,RACE_FAIRY,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511001306.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,89194033,0,0x21,2500,2000,6,RACE_FAIRY,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,89194033)
	Duel.SpecialSummon(token,0,tp,tp,true,false,POS_FACEUP)
end
function c511001306.incon(e)
	return Duel.IsExistingMatchingCard(c511001306.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil,511001305)
end
function c511001306.infilter(e,c)
	return c:GetCode()==89194033
end
