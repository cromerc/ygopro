--Contract with the Void
function c511000790.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c511000790.condition)
	e1:SetTarget(c511000790.target)
	e1:SetOperation(c511000790.activate)
	c:RegisterEffect(e1)
end
function c511000790.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>2
end
function c511000790.filter(c,e,tp)
	return c:IsSetCard(0xb) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000790.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000790.filter,tp,LOCATION_HAND+LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511000790.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetFieldGroup(p,LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_DISCARD)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sp=Duel.SelectMatchingCard(tp,c511000790.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if sp:GetCount()>0 then
		Duel.SpecialSummon(sp,0,tp,tp,false,false,POS_FACEUP)
	end
end
