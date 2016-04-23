--Sacred Spirit Beast Mount Petolfin
function c13700017.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e0:SetCode(EFFECT_SPSUMMON_CONDITION)
	e0:SetValue(c13700017.splimit)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetRange(LOCATION_EXTRA)
	e1:SetCondition(c13700017.fusioncon)
	e1:SetOperation(c13700017.fusionop)
	e1:SetValue(SUMMON_TYPE_FUSION)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c13700017.cost)
	e2:SetTarget(c13700017.target2)
	e2:SetOperation(c13700017.operation2)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c13700017.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c13700017.mfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x1376) or c:IsSetCard(0x1377))
end
function c13700017.fusionfilter1(c)
	return c:IsSetCard(0x1376) 
end
function c13700017.fusionfilter2(c)
	return c:IsSetCard(0x1377)
end
function c13700017.fusioncon(e,c,og)
	if c==nil then return true end
	local tp=c:GetControler()
	local mg=Duel.GetMatchingGroup(c13700017.mfilter,tp,LOCATION_MZONE,0,nil)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and mg:IsExists(c13700017.fusionfilter1,1,nil,mg)
		and mg:IsExists(c13700017.fusionfilter2,1,nil,mg)
end
function c13700017.fusionop(e,tp,eg,ep,ev,re,r,rp,c,og)
	local mg=Duel.GetMatchingGroup(c13700017.mfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g1=mg:FilterSelect(tp,c13700017.fusionfilter1,1,1,nil,mg)
	local tc1=g1:GetFirst()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FMATERIAL)
	local g2=mg:FilterSelect(tp,c13700017.fusionfilter2,1,1,nil,mg)
	local tc2=g2:GetFirst()
	g1:Merge(g2)
	Duel.Remove(g1,POS_FACEUP,REASON_EFFECT+REASON_MATERIAL+REASON_FUSION)
end
function c13700017.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToExtraAsCost() end
	Duel.SendtoDeck(c,nil,0,REASON_COST)
end
function c13700017.filter1(c,e,tp)
	return c:IsSetCard(0x1376)and  
	(c:IsCode(13700018) and Duel.GetFlagEffect(tp,13700018)==0) or 
	(c:IsCode(13700011) and Duel.GetFlagEffect(tp,13700011)==0)
end
function c13700017.filter2(c,e,tp)
	return c:IsSetCard(0x1377) and
	(c:IsCode(13700010) and Duel.GetFlagEffect(tp,13700010)==0) or
	(c:IsCode(13700031) and Duel.GetFlagEffect(tp,13700031)==0) or
	(c:IsCode(13700033) and Duel.GetFlagEffect(tp,13700033)==0)
end
function c13700017.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c13700017.filter1,tp,LOCATION_REMOVED,0,1,nil,e,tp)
		and Duel.IsExistingMatchingCard(c13700017.filter2,tp,LOCATION_REMOVED,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_REMOVED)
end
function c13700017.operation2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	local g=Duel.GetMatchingGroup(c13700017.filter1,tp,LOCATION_REMOVED,0,nil,e,tp)
	local g2=Duel.GetMatchingGroup(c13700017.filter2,tp,LOCATION_REMOVED,0,nil,e,tp)
	if g:GetCount()>=1 and g2:GetCount()>=1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc1=g:Select(tp,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc2=g2:Select(tp,1,1,nil)
		Duel.SpecialSummon(tc1,0,tp,tp,false,false,POS_FACEUP_DEFENCE)
		Duel.SpecialSummon(tc2,0,tp,tp,false,false,POS_FACEUP_DEFENCE)
	end
end
