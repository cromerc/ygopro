--ＷＲＵＭ－ホープ・フォース
function c511000685.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000685.target)
	e1:SetOperation(c511000685.activate)
	c:RegisterEffect(e1)
end
function c511000685.filter1(c,e,tp)
	local rk=c:GetRank()
	return rk>0 and c:IsFaceup() and Duel.IsExistingMatchingCard(c511000685.filter2,tp,LOCATION_EXTRA,0,2,nil,rk,e,tp,c,c:GetCode())
		and c:IsCode(84013237) and c:GetOverlayGroup():GetCount()>=2
end
function c511000685.filter2(c,rk,e,tp,mc,code)
	if c.rum_limit_code and code~=c.rum_limit_code then return false end
	return (c:GetRank()==rk+1 or c:GetRank()==rk+2) and mc:IsCanBeXyzMaterial(c) 
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c511000685.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511000685.filter1(chkc,e,tp) end
	local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and c29724053[tp]
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingTarget(c511000685.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) and (not ect or math.min(ect,2)>=2) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511000685.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_EXTRA)
end
function c511000685.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local ect=c29724053 and Duel.IsPlayerAffectedByEffect(tp,29724053) and c29724053[tp]
	if ect~=nil and ect<2 then return end
	local tc=Duel.GetFirstTarget()
	if not tc or tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	local ou=tc:GetOverlayGroup()
	if ou:GetCount()<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000685.filter2,tp,LOCATION_EXTRA,0,2,2,nil,tc:GetRank(),e,tp,tc,tc:GetCode())
	if Duel.SpecialSummonStep(g:GetFirst(),SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)~=0 and
		Duel.SpecialSummonStep(g:GetNext(),SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)~=0 then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local ou1=ou:Select(tp,1,1,nil)
		Duel.Overlay(g:GetFirst(),ou1)
		ou=tc:GetOverlayGroup()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local ou2=ou:Select(tp,1,1,ou1:GetFirst())
		Duel.Overlay(g:GetNext(),ou2)
		g:GetFirst():CompleteProcedure()
		g:GetNext():CompleteProcedure()
	end
	Duel.SpecialSummonComplete()
end
