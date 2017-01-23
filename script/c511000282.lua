--Impact Revive
function c511000282.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000282.condition)
	e1:SetTarget(c511000282.target)
	e1:SetOperation(c511000282.activate)
	c:RegisterEffect(e1)
end
function c511000282.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_MAIN2
end
function c511000282.filter(c,e,tp,tid)
	return bit.band(c:GetReason(),REASON_BATTLE)~=0 and c:GetTurnID()==tid
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and Duel.GetLocationCount(c:GetOwner(),LOCATION_MZONE)>0
end
function c511000282.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tid=Duel.GetTurnCount()
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c511000282.filter(chkc,e,tp,tid) end
	if chk==0 then return Duel.IsExistingTarget(c511000282.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil,e,tp,tid) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511000282.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp,tid)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511000282.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc and tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tc:GetOwner(),tc:GetOwner(),true,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(500)
		tc:RegisterEffect(e1)
	end
end
