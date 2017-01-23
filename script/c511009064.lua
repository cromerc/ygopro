--Superheavy Samurai Trumpeteer
function c511009064.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(67757079,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetCost(c511009064.spcost)
	e1:SetCondition(c511009064.spcon)
	e1:SetTarget(c511009064.sptg)
	e1:SetOperation(c511009064.spop)
	c:RegisterEffect(e1)
end
function c511009064.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c511009064.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and not Duel.IsExistingMatchingCard(c511009064.filter,tp,LOCATION_GRAVE,0,1,nil)
end
function c511009064.cfilter(c)
	return c:IsSetCard(0x9a) and c:IsAbleToGraveAsCost()
end
function c511009064.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009064.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c511009064.cfilter,1,1,REASON_COST)
end
function c511009064.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511009064.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.SpecialSummon(e:GetHandler(),0,tp,tp,false,false,POS_FACEUP)
	end
end
