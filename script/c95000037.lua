--Infinite Machine Ain Soph
function c95000037.initial_effect(c)
    --Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCost(c95000037.cost)
	e1:SetTarget(c95000037.target)
	c:RegisterEffect(e1)
	--sp summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c95000037.spcon)
	e3:SetTarget(c95000037.sptg)
	e3:SetOperation(c95000037.spop)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c95000037.descon)
	e4:SetTarget(c95000037.destg)
	e4:SetOperation(c95000037.desop)
	c:RegisterEffect(e4)
	--cannot disable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_DISABLE)
	c:RegisterEffect(e5)
end
c95000037.mark=0
function c95000037.cfilter(c)
	return c:IsCode(95000029) and c:IsAbleToGraveAsCost()
end
function c95000037.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c95000037.cfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c95000037.cfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c95000037.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	if c95000037.spcon(e,tp,eg,ep,ev,re,r,rp) and c95000037.sptg(e,tp,eg,ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,aux.Stringid(65872270,0)) then
		e:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND)
		e:SetOperation(c95000037.spop)
		c95000037.sptg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end
function c95000037.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function c95000037.spfilter(c,e,tp)
	return c:IsSetCard(0x4bde) and c:IsType(TYPE_MONSTER) 
		and c:IsCanBeSpecialSummoned(e,0,tp,true,false) and c:GetCode()~=95000042
end
function c95000037.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingMatchingCard(c95000037.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) 
		and e:GetHandler():GetFlagEffect(95000037)==0 end
	e:GetHandler():RegisterFlagEffect(95000037,RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c95000037.spop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c95000037.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp):GetFirst()
	if tc and Duel.SpecialSummon(tc,0,tp,tp,true,false,POS_FACEUP) then
		tc:CompleteProcedure()
	end
end
function c95000037.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c95000037.filter(c)
	return c:IsFaceup() and (c:IsSetCard(0x4bde) or c:IsSetCard(0x4a) or c:IsCode(74530899)) and c:IsDestructable()
end
function c95000037.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local sg=Duel.GetMatchingGroup(c95000037.filter,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c95000037.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local sg=Duel.GetMatchingGroup(c95000037.filter,tp,LOCATION_MZONE,0,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
