--伏魔殿－悪魔の迷宮－
function c805000066.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_FIEND))
	e2:SetValue(500)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetDescription(aux.Stringid(805000066,0))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetTarget(c805000066.target)
	e3:SetOperation(c805000066.operation)
	c:RegisterEffect(e3)
end
function c805000066.filter1(c,e,tp)
	local lv=c:GetLevel()
	return c:IsSetCard(0x45) and Duel.IsExistingTarget(Card.IsRace,tp,LOCATION_MZONE,0,1,c,RACE_FIEND)
	  and Duel.IsExistingTarget(c805000066.filter2,tp,0x13,0,1,nil,e,tp,lv)
end
function c805000066.filter2(c,e,tp,lv)
	local lv2=c:GetLevel()
	return lv2==lv and c:IsSetCard(0x45) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c805000066.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c805000066.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingTarget(c805000066.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp)
		and Duel.GetFlagEffect(tp,805000066)==0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c805000066.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
	Duel.RegisterFlagEffect(tp,805000066,RESET_PHASE+PHASE_END,0,1)
end
function c805000066.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0):Filter(Card.IsRace,tc,RACE_FIEND)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<-1 and g:GetCount()==0 then return end
	local td=g:Select(tp,1,1,tc)
	Duel.Remove(td,POS_FACEUP,REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.SelectMatchingCard(tp,c805000066.filter2,tp,0x13,0,1,1,nil,e,tp,tc:GetLevel())
	if tg:GetCount()>0 then
		Duel.SpecialSummon(tg,0,tp,tp,false,false,POS_FACEUP)
	end
end