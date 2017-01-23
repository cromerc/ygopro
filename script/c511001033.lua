--先史遺産の共鳴
function c511001033.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511001033.target)
	e1:SetOperation(c511001033.activate)
	c:RegisterEffect(e1)
end
function c511001033.filter1(c,e,tp)
	return c:IsFaceup() and c:IsSetCard(0x70) and c:GetLevel()>0 
		and Duel.IsExistingMatchingCard(c511001033.filter2,tp,LOCATION_HAND,0,1,nil,c:GetLevel(),e,tp)
end
function c511001033.filter2(c,lv,e,tp)
	return c:IsSetCard(0x70) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==lv+1
end
function c511001033.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511001033.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511001033.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511001033.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511001033.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<0 then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001033.filter2,tp,LOCATION_HAND,0,1,1,nil,tc:GetLevel(),e,tp)
	local sc=g:GetFirst()
	Duel.SpecialSummon(sc,0,tp,tp,false,false,POS_FACEUP)
end

