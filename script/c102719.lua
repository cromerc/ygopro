---フォーム・チェンジ
function c102719.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(102719,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c102719.target)
	e1:SetOperation(c102719.operation)
	c:RegisterEffect(e1)
end
function c102719.filter1(c,e,tp)
	local lv=c:GetOriginalLevel()
	local code=c:GetCode()
	return c:IsAbleToDeck()
	and c:IsSetCard(0x8)
	and c:IsType(TYPE_MONSTER)
	and c:IsType(TYPE_FUSION)
	and Duel.IsExistingMatchingCard(c102719.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp,lv,code)
end
function c102719.filter2(c,e,tp,lv,code)
	return c:IsCanBeSpecialSummoned(e,0,tp,true,false)
	and c:GetCode()~=code
	and c:GetLevel()==lv
	and c:IsSetCard(0xa008)
end
function c102719.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingTarget(c102719.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	local g=Duel.SelectTarget(tp,c102719.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(tp,CATEGORY_TODECK,g,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(tp,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end	
function c102719.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsAbleToDeck() then
		local lv=tc:GetOriginalLevel()
		local code=tc:GetCode()
		if Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)~=0 then
			local g=Duel.GetMatchingGroup(c102719.filter2,tp,LOCATION_EXTRA,0,nil,e,tp,lv,code)
			if g:GetCount()>0 then
				local tg=g:Select(tp,1,1,nil)
				local sc=tg:GetFirst()
				Duel.SpecialSummon(sc,0,tp,tp,true,false,POS_FACEUP)
			end
		end
	end
end	
