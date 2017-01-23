--Star Blaster
function c511001675.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DICE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetTarget(c511001675.target)
	e1:SetOperation(c511001675.activate)
	c:RegisterEffect(e1)
end
function c511001675.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c511001675.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001675.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001675.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001675.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c511001675.spfilter(c,lv,e,tp)
	return c:GetLevel()==lv and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001675.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local dice=Duel.TossDice(tp,1)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(dice)
		tc:RegisterEffect(e1)
		local g=Duel.GetMatchingGroup(c511001675.spfilter,tp,LOCATION_HAND,0,nil,tc:GetLevel(),e,tp)
		if tc:IsReleasableByEffect() and Duel.GetLocationCount(tp,LOCATION_MZONE)>-1 and g:GetCount()>0 
			and Duel.SelectYesNo(tp,aux.Stringid(102380,0)) then
			Duel.Release(tc,REASON_EFFECT)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:Select(tp,1,1,nil)
			Duel.BreakEffect()
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
