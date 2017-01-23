--Land Power
function c511002065.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetDescription(aux.Stringid(511002065,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCondition(c511002065.spcon)
	e2:SetTarget(c511002065.sptg)
	e2:SetOperation(c511002065.spop)
	c:RegisterEffect(e2)
	--cannot be battle target
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e3:SetRange(LOCATION_FZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetValue(c511002065.tg)
	c:RegisterEffect(e3)
	--direct attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_DIRECT_ATTACK)
	e4:SetRange(LOCATION_FZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetCondition(c511002065.con)
	e4:SetTarget(c511002065.tg)
	c:RegisterEffect(e4)
	local e5=e2:Clone()
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e5)
	local e6=e2:Clone()
	e6:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e6)
end
function c511002065.cfilter(c,tp)
	return c:IsFaceup() and (c:IsSetCard(0x215) or c:IsCode(31437713)) and c:IsControler(tp)
end
function c511002065.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002065.cfilter,1,nil,tp)
end
function c511002065.spfilter(c,e,tp)
	return c:IsSetCard(0x215) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002065.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c511002065.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK+LOCATION_HAND)
end
function c511002065.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511002065.spfilter,tp,LOCATION_DECK+LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511002065.tg(e,c)
	return c:IsFaceup() and (c:IsSetCard(0x215) or c:IsCode(31437713))
end
function c511002065.filter(c)
	return c:IsFaceup() and (c:IsSetCard(0x215) or c:IsCode(31437713))
end
function c511002065.con(e,c)
	return not Duel.IsExistingMatchingCard(c511002065.filter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
