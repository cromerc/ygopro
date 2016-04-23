---ワイトプリンス
function c501001047.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetValue(32274490)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(501001047,0))
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c501001047.tgcon)
	e2:SetTarget(c501001047.tgtg)
	e2:SetOperation(c501001047.tgop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(501001047,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCost(c501001047.spcos)
	e3:SetTarget(c501001047.sptg)
	e3:SetOperation(c501001047.spop)
	c:RegisterEffect(e3)
end	
function c501001047.tgcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return not c:IsReason(REASON_RETURN)
end
function c501001047.tgfilter1(c)
	return c:IsAbleToGrave()
	and c:IsCode(32274490)
end
function c501001047.tgfilter2(c)
	return c:IsAbleToGrave()
	and c:IsCode(40991587)
end
function c501001047.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingMatchingCard(c501001047.tgfilter1,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil)
	and Duel.IsExistingMatchingCard(c501001047.tgfilter2,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil)
	end
	Duel.SetOperationInfo(tp,CATEGORY_TOGRAVE,nil,2,tp,LOCATION_HAND+LOCATION_DECK)
end
function c501001047.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local g1=Duel.GetMatchingGroup(c501001047.tgfilter1,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
	local g2=Duel.GetMatchingGroup(c501001047.tgfilter2,tp,LOCATION_HAND+LOCATION_DECK,0,nil)
	if g1:GetCount()>0 and g2:GetCount()>0 then
		local tg1=g1:Select(tp,1,1,nil)
		local tg2=g2:Select(tp,1,1,nil)
		local tg=Group.CreateGroup()
		tg:Merge(tg1)
		tg:Merge(tg2)
		Duel.SendtoGrave(tg,REASON_EFFECT)
	end
end
function c501001047.spcfilter(c)
	return c:IsAbleToRemoveAsCost()
	and c:IsCode(32274490)
end
function c501001047.spcos(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingMatchingCard(c501001047.spcfilter,tp,LOCATION_GRAVE,0,2,c)
	and c:IsAbleToRemoveAsCost()
	end
	local g=Duel.SelectMatchingCard(tp,c501001047.spcfilter,tp,LOCATION_GRAVE,0,2,2,c)
	g:AddCard(c)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end	
function c501001047.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
	and c:IsCode(36021814)
end
function c501001047.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c501001047.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp)
	end
	Duel.SetOperationInfo(tp,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end	
function c501001047.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c501001047.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()>0 then
		local tg=g:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end	
