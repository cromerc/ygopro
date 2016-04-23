--エクシーズ・レセプション
function c805000060.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(805000060,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c805000060.target)
	e1:SetOperation(c805000060.operation)
	c:RegisterEffect(e1)
end
function c805000060.filter1(c,e,tp)
	local lv=c:GetLevel()
	return Duel.IsExistingTarget(c805000060.filter2,tp,LOCATION_HAND,0,1,nil,e,tp,lv)
end
function c805000060.filter2(c,e,tp,lv)
	local lv2=c:GetLevel()
	return lv2==lv and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c805000060.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c805000060.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c805000060.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c805000060.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c805000060.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)==0 then return end
	local c=e:GetHandler()
	local tg=Duel.GetFirstTarget()
	local tc=Duel.SelectMatchingCard(tp,c805000060.filter2,tp,LOCATION_HAND,0,1,1,nil,e,tp,tg:GetLevel())
	if tc:GetCount()>0 and Duel.SpecialSummonStep(tc:GetFirst(),0,tp,tp,false,false,POS_FACEUP)  then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:GetFirst():RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:GetFirst():RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc:GetFirst():RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_SET_DEFENCE_FINAL)
		e4:SetValue(0)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		tc:GetFirst():RegisterEffect(e4)
		Duel.SpecialSummonComplete()
	end
end