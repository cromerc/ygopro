--Light of the Shadows
function c511000359.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000359.cost)
	e1:SetTarget(c511000359.target)
	e1:SetOperation(c511000359.activate)
	c:RegisterEffect(e1)
end
function c511000359.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCurrentPhase()~=PHASE_MAIN2 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511000359.filter(c,e,tp)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK) and Duel.IsExistingTarget(c511000359.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,c:GetLevel())
end
function c511000359.spfilter(c,e,tp,lv)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==lv
end
function c511000359.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c511000359.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511000359.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
end
function c511000359.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c511000359.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sp=Duel.SelectMatchingCard(tp,c511000359.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,g:GetFirst():GetLevel())
		if sp:GetCount()~=0 then
			Duel.SpecialSummon(sp,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
