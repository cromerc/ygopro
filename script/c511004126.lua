--Kurivolt(Anime)
--scripted by:urielkama
function c511004126.initial_effect(c)
--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511004126,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetTarget(c511004126.target)
	e1:SetOperation(c511004126.activate)
	c:RegisterEffect(e1)
end
function c511004126.ofilter(c)
	return c:GetOverlayCount()~=0
end
function c511004126.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511004126.ofilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511004126.ofilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.SelectTarget(tp,c511004126.ofilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511004126.activate(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
	if tc:GetOverlayCount()==0 then return end
	local g=tc:GetOverlayGroup():Filter(Card.IsAbleToGraveAsCost,nil):Select(tp,1,2,nil)
	if g:GetCount()>0 then
	local ct=Duel.SendtoGrave(g,REASON_EFFECT)
	e:SetLabel(ct)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if not ft==e:GetLabel() or not Duel.IsPlayerCanSpecialSummonMonster(tp,511004125,0,0,300,200,1,RACE_THUNDER,ATTRIBUTE_LIGHT) then return end
		for i=1,e:GetLabel() do
		local token=Duel.CreateToken(tp,511004125)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		end
	Duel.SpecialSummonComplete()
	end
end