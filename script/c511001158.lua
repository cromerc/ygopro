--Necro Sacrifice
function c511001158.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001158.tg)
	e1:SetOperation(c511001158.op)
	c:RegisterEffect(e1)
end
function c511001158.filter(c,e,tp)
	local mi,ma=c:GetTributeRequirement()
	return c:IsLevelAbove(5) and ma>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>ma-1
		and Duel.IsExistingMatchingCard(c511001158.spfilter,tp,LOCATION_GRAVE,0,ma,nil,e,tp)
end
function c511001158.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001158.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_HAND and chkc:GetControler()==tp and c511001158.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511001158.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(89252153,0))
	local g=Duel.SelectTarget(tp,c511001158.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,nil)
end
function c511001158.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local mi,ma=tc:GetTributeRequirement()
	if tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511001158.spfilter,tp,LOCATION_GRAVE,0,ma,ma,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,1-tp,1-tp,false,false,POS_FACEUP)
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SUMMON_PROC)
		e1:SetCondition(c511001158.ntcon)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c511001158.ntcon(e,c)
	if c==nil then return true end
	return c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
