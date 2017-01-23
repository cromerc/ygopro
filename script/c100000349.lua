--チーム・プレー
function c100000349.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000349.target)
	e1:SetOperation(c100000349.activate)
	c:RegisterEffect(e1)
end
function c100000349.filter1(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.IsExistingTarget(c100000349.filter2,tp,LOCATION_MZONE,0,1,nil,c:GetRace())
end
function c100000349.filter2(c,rc)
	local lv=c:GetLevel()
	return lv>0 and c:IsRace(rc) and c:IsFaceup() and Duel.IsExistingTarget(c100000349.filter3,tp,LOCATION_MZONE,0,1,c,rc,lv)
end
function c100000349.filter3(c,rc,lv)
	local lv2=c:GetLevel()
	return lv2==lv and c:IsFaceup() and c:IsRace(rc)
end
function c100000349.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c100000349.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c100000349.filter1,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c100000349.filter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c100000349.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(4)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		Duel.SpecialSummonComplete()
	end
end
