--アイス・ミラー
function c100000158.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000158.target)
	e1:SetOperation(c100000158.activate)
	c:RegisterEffect(e1)
end
function c100000158.filter(c,e,tp)
	return c:IsFaceup() and c:IsLevelBelow(3) and c:IsAttribute(ATTRIBUTE_WATER)
	and Duel.GetFirstMatchingCard(c100000158.filter2,tp,LOCATION_DECK,0,nil,c:GetCode(),e,tp)
end
function c100000158.filter2(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000158.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000158.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c100000158.filter,tp,LOCATION_MZONE,0,1,nil,e,tp)end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(100000158,0))
	Duel.SelectTarget(tp,c100000158.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c100000158.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.GetFirstMatchingCard(c100000158.filter2,tp,LOCATION_DECK,0,nil,tc:GetCode(),e,tp)
		if Duel.SpecialSummonStep(sg,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		sg:RegisterEffect(e1)
		Duel.SpecialSummonComplete()
		end
	end
end
