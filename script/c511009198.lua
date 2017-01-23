--Galaxy-Eyes Nova
function c511009198.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_ATTACK,TIMING_ATTACK)
	e1:SetCost(c511009198.cost)
	e1:SetTarget(c511009198.target)
	e1:SetOperation(c511009198.activate)
	c:RegisterEffect(e1)
end
function c511009198.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x107b) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x107b)
	Duel.Release(g,REASON_COST)
end
function c511009198.filter(c,e,tp)
	return c:IsSetCard(0x107b) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511009198.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c511009198.filter(chkc,e,tp) end
	if chk==0 then
		if e:GetLabel()==1 then
			e:SetLabel(0)
			return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
				and Duel.IsExistingTarget(c511009198.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		else
			return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
				and Duel.IsExistingTarget(c511009198.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
		end
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511009198.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	e:SetLabel(0)
end
function c511009198.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end
