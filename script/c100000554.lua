--クロス・チェンジ
function c100000554.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetLabel(0)
	e1:SetTarget(c100000554.target)
	e1:SetOperation(c100000554.activate)
	c:RegisterEffect(e1)
end
function c100000554.filter1(c,setcard1,setcard2,e,tp)
	local lv=c:GetLevel()
	return c:IsSetCard(setcard1) and c:IsAbleToDeck()
	 and Duel.IsExistingMatchingCard(c100000554.filter2,tp,LOCATION_DECK,0,1,nil,setcard2,lv,e,tp)
end
function c100000554.filter2(c,setcard,lv,e,tp)
	return c:IsSetCard(setcard) and c:GetLevel()==lv and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000554.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000554.filter1,tp,LOCATION_MZONE,0,1,nil,0x3008,0x1f,e,tp)
		or Duel.IsExistingMatchingCard(c100000554.filter1,tp,LOCATION_MZONE,0,1,nil,0x1f,0x3008,e,tp)
	end
	local opt=0
	if Duel.IsExistingMatchingCard(c100000554.filter1,tp,LOCATION_MZONE,0,1,nil,0x3008,0x1f,e,tp)
		and Duel.IsExistingMatchingCard(c100000554.filter1,tp,LOCATION_MZONE,0,1,nil,0x1f,0x3008,e,tp) then
		opt=Duel.SelectOption(tp,aux.Stringid(100000554,0),aux.Stringid(100000554,1))
	else
		if Duel.IsExistingMatchingCard(c100000554.filter1,tp,LOCATION_MZONE,0,1,nil,0x1f,0x3008,e,tp) then
		opt=1
		end
	end
	Duel.SetTargetParam(opt)
	local setcard=nil
	if opt==0 then
		setcard1=0x3008
		setcard2=0x1f
	else
		setcard1=0x1f
		setcard2=0x3008
		e:SetLabel(1)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c100000554.filter1,tp,LOCATION_MZONE,0,1,1,nil,setcard1,setcard2,e,tp)
end
function c100000554.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	local opt=e:GetLabel()
	if opt==0 then
		setcard=0x1f
	else
		setcard=0x3008
	end
	local lv=tc:GetLevel()
	local dt=Duel.GetMatchingGroup(c100000554.filter2,tp,LOCATION_DECK,0,nil,setcard,lv,e,tp)
	if tc:IsLocation(LOCATION_MZONE) and tc:IsRelateToEffect(e) and dt:GetCount()>0 then
		Duel.SendtoDeck(tc,nil,1,REASON_EFFECT)
		local dt=Duel.SelectMatchingCard(tp,c100000554.filter2,tp,LOCATION_DECK,0,1,1,nil,setcard,lv,e,tp)
		if dt then
			Duel.SpecialSummon(dt,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
