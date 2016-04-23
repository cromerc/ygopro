---シャドール・ファルコン
function c501001023.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(501001023,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_LEAVE_GRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_FLIP)
	e1:SetCondition(c501001023.spcon1)
	e1:SetCost(c501001023.spcos1)
	e1:SetTarget(c501001023.sptg1)
	e1:SetOperation(c501001023.spop1)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(501001023,1))
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_LEAVE_GRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c501001023.spcon2)
	e2:SetCost(c501001023.spcos2)
	e2:SetTarget(c501001023.sptg2)
	e2:SetOperation(c501001023.spop2)
	c:RegisterEffect(e2)
end	
function c501001023.spcon1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return Duel.GetFlagEffect(tp,501001023)==0
end
function c501001023.spcos1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetFlagEffect(tp,501001023)==0 end
	Duel.RegisterFlagEffect(tp,501001023,RESET_PHASE+PHASE_END,0,1)
end	
function c501001023.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN)
	and c:IsType(TYPE_MONSTER)
	and c:IsSetCard(0x9b)
	and c:GetCode()~=501001023
end
function c501001023.sptg1(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingTarget(c501001023.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	local g=Duel.SelectTarget(tp,c501001023.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(tp,CATEGORY_SPECIAL_SUMMON,g,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(tp,CATEGORY_LEAVE_GRAVE,g,1,tp,0)
end	
function c501001023.spop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEDOWN_DEFENCE)
	end
end	
function c501001023.spcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return Duel.GetFlagEffect(tp,501001023)==0
	and c:IsReason(REASON_EFFECT)
	and not c:IsReason(REASON_RETURN)
end
function c501001023.spcos2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetFlagEffect(tp,501001023)==0 end
	Duel.RegisterFlagEffect(tp,501001023,RESET_PHASE+PHASE_END,0,1)
end	
function c501001023.filter(c)
	return c:IsFaceup()
end
function c501001023.sptg2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEDOWN)
	end
	Duel.SetOperationInfo(tp,CATEGORY_SPECIAL_SUMMON,c,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(tp,CATEGORY_LEAVE_GRAVE,c,1,tp,0)
end	
function c501001023.spop2(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local tp=c:GetControler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEDOWN_DEFENCE)
	end
end	
