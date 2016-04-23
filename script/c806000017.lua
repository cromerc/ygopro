--ゴーストリック・スペクター
function c806000017.initial_effect(c)
	--sumlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c806000017.excon)
	c:RegisterEffect(e1)
	--turn set
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c806000017.target)
	e2:SetOperation(c806000017.operation)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DRAW)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e3:SetRange(LOCATION_HAND)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c806000017.spcon)
	e3:SetTarget(c806000017.sptg)
	e3:SetOperation(c806000017.spop)
	c:RegisterEffect(e3)
end
function c806000017.exfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8c)
end
function c806000017.excon(e)
	return not Duel.IsExistingMatchingCard(c806000017.exfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c806000017.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(806000017)==0 end
	c:RegisterFlagEffect(806000017,RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c806000017.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENCE)
	end
end
function c806000017.spfilter(c,tp)
	return c:GetReasonPlayer()~=tp and c:IsSetCard(0x8c) and c:IsType(TYPE_MONSTER) and c:GetOwner()==tp
	and (c:IsReason(REASON_EFFECT) or c:IsReason(REASON_BATTLE))
end
function c806000017.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c806000017.spfilter,1,nil,tp)
end
function c806000017.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c806000017.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEDOWN_DEFENCE)
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end