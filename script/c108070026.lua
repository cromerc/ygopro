--武神ーアラスダ
function c108070026.initial_effect(c)
	c:SetUniqueOnField(1,0,108070026)
	--removed
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_REMOVE)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(LOCATION_GRAVE,0)
	e1:SetCondition(c108070026.spcon)
	e1:SetTarget(c108070026.sptg)
	e1:SetOperation(c108070026.spop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetCondition(c108070026.thcon)
	e2:SetTarget(c108070026.thtg)
	e2:SetOperation(c108070026.thop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_TO_HAND)
	e3:SetCondition(c108070026.regcon)
	e3:SetOperation(c108070026.regop)
	c:RegisterEffect(e3)
end
function c108070026.filter(c,tp)
	return c:GetPreviousControler()==tp and c:IsPreviousLocation(LOCATION_GRAVE)
	 and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x88)
end
function c108070026.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c108070026.filter,1,nil,tp)
end
function c108070026.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c108070026.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c108070026.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(108070026)>0
end

function c108070026.thtg(e,tp,eg,ep,ev,re,r,rp,chk)	
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
	e:GetHandler():ResetNegateEffect(25789292,97268402)
end
function c108070026.thop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)>0 then
		Duel.ConfirmCards(1-tp,g)
		Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT)
	end
end
function c108070026.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousLocation(LOCATION_DECK) and not c:IsReason(REASON_DRAW)
		and c:IsType(TYPE_MONSTER) and c:IsSetCard(0x88)
end
function c108070026.regcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c108070026.cfilter,1,nil,tp)
end
function c108070026.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(108070026,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end