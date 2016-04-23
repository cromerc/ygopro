--キャットフード
function c100000180.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000180.condition)
	e1:SetOperation(c100000180.activate)
	c:RegisterEffect(e1)
end
function c100000180.filter1(c,e,tp)
	return c:IsCode(100000171) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000180.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
	and Duel.IsExistingMatchingCard(c100000180.filter1,tp,0x13,0,1,nil,e,tp) 
	and Duel.CheckReleaseGroup(c:GetControler(),Card.IsCode,1,nil,100000170)
end
function c100000180.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local gr=Duel.SelectReleaseGroup(c:GetControler(),Card.IsCode,1,1,nil,100000170)
	if gr:GetCount()<1 then return false end		
	Duel.Release(gr,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c100000180.filter1,tp,0x13,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP_ATTACK)
	end
end
