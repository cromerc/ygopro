---光竜星－リフン
function c501001032.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(501001032,0))
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CHAIN_UNIQUE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c501001032.spcon)
	e1:SetCost(c501001032.spcos)
	e1:SetTarget(c501001032.sptg)
	e1:SetOperation(c501001032.spop)
	c:RegisterEffect(e1)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(501001032,0))
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_CHAIN_UNIQUE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c501001032.condition)
	e1:SetCost(c501001032.cost)
	e1:SetTarget(c501001032.target)
	e1:SetOperation(c501001032.operation)
	c:RegisterEffect(e1)
end	
function c501001032.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return Duel.GetFlagEffect(tp,501001032)==0
	and c:IsReason(REASON_DESTROY)
	and c:GetPreviousControler()==tp
	and c:IsPreviousLocation(LOCATION_MZONE)
end
function c501001032.spcos(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetFlagEffect(tp,501001032)==0 end
	Duel.RegisterFlagEffect(tp,501001032,RESET_PHASE+PHASE_END,0,1)
end	
function c501001032.spfilter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
	and c:GetCode()~=501001032
	and c:IsSetCard(0x9c)
end
function c501001032.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingMatchingCard(c501001032.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(tp,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end	
function c501001032.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local g=Duel.GetMatchingGroup(c501001032.spfilter,tp,LOCATION_DECK,0,nil,e,tp)
	if g:GetCount()>0 then
		local tg=g:Select(tp,1,1,nil)
		local tc=tg:GetFirst()
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end	
function c501001032.filter1(c,tp)
	return c:GetPreviousControler()==tp
	and c:IsReason(REASON_DESTROY)
	and c:IsPreviousLocation(LOCATION_MZONE)
	and c:IsSetCard(0x9c)
end
function c501001032.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return Duel.GetFlagEffect(tp,501001032)==0
	and eg:IsExists(c501001032.filter1,1,nil,tp)
end
function c501001032.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetFlagEffect(tp,501001032)==0 end
	Duel.RegisterFlagEffect(tp,501001032,RESET_PHASE+PHASE_END,0,1)
end	
function c501001032.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
	end
	Duel.SetOperationInfo(tp,CATEGORY_SPECIAL_SUMMON,c,1,tp,LOCATION_GRAVE)
end	
function c501001032.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	local tp=c:GetControler()
	if c:IsRelateToEffect(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
			--redirect
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
			e1:SetCondition(c501001032.recon)
			e1:SetValue(LOCATION_REMOVED)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e1)
		end
	end
end	
function c501001032.recon(e)
	return e:GetHandler():IsFaceup()
end
