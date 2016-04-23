--Scripted by Eerie Code
--Hot Red Dragon Archfiend Belial
function c6441.initial_effect(c)
	--Synchro Summon
	aux.AddSynchroProcedure2(c,nil,aux.NonTuner(c6441.synfil))
	c:EnableReviveLimit()
	--Special Summon Red Daemon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6441,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,6441)
	e1:SetCost(c6441.spcost)
	e1:SetTarget(c6441.sptg1)
	e1:SetOperation(c6441.spop1)
	c:RegisterEffect(e1)
	--Special Summon Resonators
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCountLimit(1,6442)
	e2:SetCondition(c6441.spcon)
	e2:SetTarget(c6441.sptg2)
	e2:SetOperation(c6441.spop2)
	c:RegisterEffect(e2)
end

function c6441.synfil(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsRace(RACE_DRAGON)
end

function c6441.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsReleasable,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsReleasable,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c6441.spfilter1(c,e,tp)
	return c:IsSetCard(0x1045) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c6441.sptg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c6441.spfilter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and
		Duel.IsExistingTarget(c6441.spfilter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c6441.spfilter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c6441.spop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c6441.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c6441.spfil1(c,e,tp)
	return c:IsType(TYPE_TUNER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.IsExistingMatchingCard(c6441.spfil2,tp,LOCATION_GRAVE,0,1,nil,e,tp,c:GetLevel())
end
function c6441.spfil2(c,e,tp,lv)
	return c:IsType(TYPE_TUNER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==lv and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c6441.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and Duel.IsExistingMatchingCard(c6441.spfil1,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c6441.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c6441.spfil1,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g1:GetCount()>0 then
		local tc=g1:GetFirst()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c6441.spfil2,tp,LOCATION_GRAVE,0,1,1,tc,e,tp,tc:GetLevel())
		g1:Merge(g2)
		Duel.SpecialSummon(g1,0,tp,tp,false,false,POS_FACEUP_DEFENCE)
	end
end