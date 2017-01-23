--過去世
function c100000312.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetLabel(0)
	e1:SetCost(c100000312.cost)
	e1:SetTarget(c100000312.target)
	e1:SetOperation(c100000312.activate)
	c:RegisterEffect(e1)
end
function c100000312.filter1(c,e,tp)
	local lv=c:GetLevel()
	local atk=c:GetAttack()
	return lv>0 and Duel.IsExistingMatchingCard(c100000312.filter2,tp,LOCATION_EXTRA,0,1,nil,lv,atk,e,tp)
end
function c100000312.filter2(c,lv,atk,e,tp)
	return c:GetLevel()==lv and c:GetAttack()==atk and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000312.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c100000312.filter1,1,nil,e,tp) end
	local rg=Duel.SelectReleaseGroup(tp,c100000312.filter1,1,1,nil,e,tp)
	Duel.Release(rg,REASON_COST)
	e:SetLabel(rg:GetFirst():GetAttack())
	e:SetLabelObject(rg:GetFirst())
end
function c100000312.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()==0 then return false end
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c100000312.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local atk=e:GetLabel()
	local lv=e:GetLabelObject():GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000312.filter2,tp,LOCATION_EXTRA,0,1,1,nil,lv,atk,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end
