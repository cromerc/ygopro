--リペア・パペット
function c100000209.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c100000209.condition)
	e1:SetTarget(c100000209.target)
	e1:SetOperation(c100000209.operation)
	c:RegisterEffect(e1)
end
function c100000209.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp 
		and c:IsLevelBelow(4) and (c:IsSetCard(0x303) or c:IsSetCard(0x83))
end
function c100000209.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100000209.cfilter,1,nil,tp)
end
function c100000209.spfilter(c,e,tp,code)
	return c:GetCode()==code and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000209.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local t=Duel.GetAttackTarget()
	local code=nil
	if a:IsReason(REASON_BATTLE) and (a:IsSetCard(0x303) or a:IsSetCard(0x83)) then code=a:GetCode() end
	if t:IsReason(REASON_BATTLE) and (t:IsSetCard(0x303) or t:IsSetCard(0x83)) then code=t:GetCode() end	
	if code==nil then return end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000209.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp,code) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c100000209.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local a=Duel.GetAttacker()
	local t=Duel.GetAttackTarget()
	local code=nil
	if a:IsReason(REASON_BATTLE) and (a:IsSetCard(0x303) or a:IsSetCard(0x83)) then code=a:GetCode() end
	if t:IsReason(REASON_BATTLE) and (t:IsSetCard(0x303) or t:IsSetCard(0x83)) then code=t:GetCode() end
	if code==nil then return end
	local g=Duel.SelectMatchingCard(tp,c100000209.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp,code)
	Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
end
