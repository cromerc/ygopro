--リボーン・パズル
function c804000093.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c804000093.ctcon)
	e1:SetTarget(c804000093.cttg)
	e1:SetOperation(c804000093.ctop)
	c:RegisterEffect(e1)
end
function c804000093.ctfilter(c,e,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_MZONE)
	 and c:IsReason(REASON_EFFECT) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c804000093.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c804000093.ctfilter,1,nil,e,tp) and eg:GetCount()==1
end
function c804000093.cttg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c804000093.ctfilter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c804000093.ctop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end