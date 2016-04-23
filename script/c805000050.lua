--輝光帝ギャラクシオン
function c805000050.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunctionF(c,aux.FilterBoolFunction(Card.IsSetCard,0x55),4),2)
	c:EnableReviveLimit()
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(805000050,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c805000050.cost)
	e1:SetTarget(c805000050.sptg)
	e1:SetOperation(c805000050.spop)
	c:RegisterEffect(e1)
end
function c805000050.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	if Duel.IsExistingMatchingCard(c805000050.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp)
	 and e:GetHandler():CheckRemoveOverlayCard(tp,2,REASON_COST) then
		if Duel.IsExistingMatchingCard(c805000050.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) then
			local opt=Duel.AnnounceNumber(tp,1,2)
			if opt==1 then
				e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
				e:SetLabel(1)
			else 
				e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
				e:SetLabel(2)
			end
		else
			e:GetHandler():RemoveOverlayCard(tp,2,2,REASON_COST)
			e:SetLabel(2)
		end
	else
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
		e:SetLabel(1)
	end
end
function c805000050.spfilter(c,e,tp)
	return c:IsCode(93717133) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c805000050.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,nil)
end
function c805000050.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local p=e:GetLabel()
	local tg=nil
	if p==1 then tg=LOCATION_HAND
	else tg=LOCATION_DECK end
	local g=Duel.SelectMatchingCard(tp,c805000050.spfilter,tp,tg,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
	 Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end