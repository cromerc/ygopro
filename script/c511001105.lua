--Synchro Spirits
function c511001105.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001105.target)
	e1:SetOperation(c511001105.activate)
	c:RegisterEffect(e1)
end
function c511001105.filter(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsAbleToRemoveAsCost()
end
function c511001105.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c511001105.filter(chk) end
	if chk==0 then return Duel.IsExistingTarget(c511001105.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c511001105.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c511001105.mgfilter(c,e,tp,sync)
	return not c:IsControler(tp) or not c:IsLocation(LOCATION_GRAVE)
		or bit.band(c:GetReason(),0x80008)~=0x80008 or c:GetReasonCard()~=sync
		or not c:IsCanBeSpecialSummoned(e,0,tp,false,false) or c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c511001105.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local mg=tc:GetMaterial()
	local sumable=true
	local sumtype=tc:GetSummonType()
	if Duel.Remove(tc,nil,POS_FACEUP,REASON_EFFECT)==0 or sumtype~=SUMMON_TYPE_SYNCHRO or mg:GetCount()==0 
		or mg:GetCount()>Duel.GetLocationCount(tp,LOCATION_MZONE)
		or mg:IsExists(c511001105.mgfilter,1,nil,e,tp,tc) then
		sumable=false
	end
	if sumable and Duel.SelectYesNo(tp,aux.Stringid(511001105,0)) then
		Duel.BreakEffect()
		Duel.SpecialSummon(mg,0,tp,tp,false,false,POS_FACEUP)
	end
end
