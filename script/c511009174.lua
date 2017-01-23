--Wind Witch Crystal Bell
function c511009174.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeFun(c,7543,c511009174.mat_filter,1,true,true)
	--copy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(30312361,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c511009174.nmtg)
	e1:SetOperation(c511009174.nmop)
	c:RegisterEffect(e1)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23899727,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c511009174.condition)
	e1:SetTarget(c511009174.target)
	e1:SetOperation(c511009174.operation)
	c:RegisterEffect(e1)
	if not c511009174.global_check then
		c511009174.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetLabel(511009174)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(aux.sumreg)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge2:SetLabel(511009174)
		Duel.RegisterEffect(ge2,0)
	end
end
c511009174.miracle_synchro_fusion=true
function c511009174.mat_filter(c)
	return c:IsFusionSetCard(0xf0)
end

function c511009174.nmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsType(TYPE_MONSTER) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsType,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,TYPE_MONSTER) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,Card.IsType,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,TYPE_MONSTER)
end
function c511009174.nmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc and tc:IsRelateToEffect(e) then
		c:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,1)
	end
end
function c511009174.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c511009174.spfilter(c,e,tp)
	return c:IsCode(7543) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) 
		and Duel.IsExistingTarget(c511009174.spfilter2,tp,LOCATION_GRAVE,0,1,c,e,tp)
end
function c511009174.spfilter2(c,e,tp)
	return c:IsLevelBelow(4) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009174.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511009174.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectTarget(tp,c511009174.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c511009174.spfilter2,tp,LOCATION_GRAVE,0,1,1,g1:GetFirst(),e,tp)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g1,g1:GetCount(),0,0)
end
function c511009174.operation(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>=tg:GetCount() then
		Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
	end
end
