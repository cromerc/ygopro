--Thousand Dragon (Anime)
function c511000539.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000539,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE)
	e1:SetCode(71625222)
	e1:SetCondition(c511000539.spcon)
	e1:SetCost(c511000539.cost)
	e1:SetTarget(c511000539.sptg)
	e1:SetOperation(c511000539.spop)
	c:RegisterEffect(e1)
end
function c511000539.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511000539.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsCode,1,nil,88819587) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,88819587)
	Duel.Release(g,REASON_COST)
end
function c511000539.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,true,false) end
	if e:GetHandler():IsLocation(LOCATION_DECK) then
		Duel.ConfirmCards(1-tp,e:GetHandler())
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511000539.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and Duel.SpecialSummon(e:GetHandler(),0,tp,tp,true,false,POS_FACEUP)>0 then
		e:GetHandler():CompleteProcedure()
	end
end
