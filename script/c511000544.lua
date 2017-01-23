--Mother Spider
function c511000544.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511000544.spcon)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000544,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511000544.cost)
	e2:SetTarget(c511000544.target)
	e2:SetOperation(c511000544.operation)
	c:RegisterEffect(e2)
end
function c511000544.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.GetFieldGroupCount(c:GetControler(),LOCATION_ONFIELD,0)==0
end
function c511000544.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511000544.spfilter(c,e,tp,code)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000544.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>=2 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
		and Duel.IsExistingTarget(c511000544.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,3,nil,e,tp,511000545) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511000544.spfilter,tp,LOCATION_HAND+LOCATION_DECK,0,3,3,nil,e,tp,511000545)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,3,0,0)
end
function c511000544.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if g:GetCount()~=3 or ft<3 or Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local tc=g:GetFirst()
	while tc do
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(511000545,RESET_EVENT+0x1ff0000,0,0)
		tc=g:GetNext()
	end
end
