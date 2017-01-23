--Gagaga Illusion
function c511001707.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001707.target)
	e1:SetOperation(c511001707.activate)
	c:RegisterEffect(e1)
end
function c511001707.filter(c,e,tp)
	return c:IsSetCard(0x54) and c:IsFaceup() and c:GetLevel()>0
end
function c511001707.spfilter(c,e,tp)
	return c:GetLevel()>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001707.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511001707.filter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingTarget(c511001707.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp)end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c511001707.filter,tp,LOCATION_MZONE,0,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c511001707.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g2,1,0,0)
end
function c511001707.activate(e,tp,eg,ep,ev,re,r,rp)
	local lc=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	if tc==lc then tc=g:GetNext() end
	if lc:IsFaceup() and lc:IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		local lv=lc:GetLevel()
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP) then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetValue(lv)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
		end
	end
end
