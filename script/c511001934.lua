--Wicked Canon
function c511001934.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--tograve
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001934,0))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511001934.tgcon)
	e2:SetTarget(c511001934.tgtg)
	e2:SetOperation(c511001934.tgop)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001934,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c511001934.spcost)
	e3:SetTarget(c511001934.sptg)
	e3:SetOperation(c511001934.spop)
	c:RegisterEffect(e3)
end
function c511001934.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511001934.tgfilter(c)
	return c:IsSetCard(0x212) and c:IsType(TYPE_SPELL) and c:IsAbleToGrave()
end
function c511001934.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001934.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_HAND+LOCATION_DECK)
end
function c511001934.tgop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511001934.tgfilter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c511001934.cfilter(c)
	return c:IsSetCard(0x212) and c:IsType(TYPE_SPELL) and c:IsAbleToRemoveAsCost()
end
function c511001934.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c511001934.cfilter,tp,LOCATION_GRAVE,0,nil)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() and g:GetCount()>0 
		and Duel.IsExistingMatchingCard(c511001934.filter1,tp,LOCATION_EXTRA,0,1,nil,e,tp,g:GetCount()) end
	e:SetLabel(g:GetCount())
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511001934.filter2(c,fc,e,tp,lv)
	local fd=c:GetCode()
	if not c:IsCanBeSpecialSummoned(e,0,tp,false,false) or c:GetLevel()<=0 or c:GetLevel()>lv*2 then return false end
	for i=1,fc.material_count do
		if fd==fc.material[i] then return true end
	end
	return false
end
function c511001934.filter1(c,e,tp,lv)
	local ct=c.material_count
	if lv<=0 then return false end
	return ct~=nil and Duel.IsExistingMatchingCard(c511001934.filter2,tp,LOCATION_DECK,0,1,nil,c,e,tp,lv)
end
function c511001934.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c511001934.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c511001934.filter1,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,e:GetLabel())
	if g:GetCount()>0 then
		Duel.ConfirmCards(1-tp,g)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local spg=Duel.SelectMatchingCard(tp,c511001934.filter2,tp,LOCATION_DECK,0,1,1,nil,g:GetFirst(),e,tp,e:GetLabel())
		Duel.SpecialSummon(spg,0,tp,tp,false,false,POS_FACEUP)
	end
end
