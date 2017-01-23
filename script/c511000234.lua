--Uria, Emperor of Divine Flames
function c511000234.initial_effect(c)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,1,511000234)
	--Cannot Special Summon except by its own Effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511000234.spcon)
	e2:SetOperation(c511000234.spop)
	c:RegisterEffect(e2)
	--ATK/DEF
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetValue(c511000234.atkdefval)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e4)
	--Trap Destruction
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511000234,0))
	e5:SetCategory(CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_IGNITION)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCountLimit(1)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetTarget(c511000234.trapdestg)
	e5:SetOperation(c511000234.trapdesop)
	c:RegisterEffect(e5)
	--Rise
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetOperation(c511000234.spr)
	c:RegisterEffect(e6)
end
function c511000234.spfilter(c)
	return c:IsType(TYPE_TRAP) and c:IsAbleToGraveAsCost()
end
function c511000234.spcon(e,c)
	if c==nil then return true end
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)==0 then
		return Duel.IsExistingMatchingCard(c511000234.spfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
			and Duel.IsExistingMatchingCard(c511000234.spfilter,c:GetControler(),LOCATION_ONFIELD,0,3,nil)
	else
		return Duel.IsExistingMatchingCard(c511000234.spfilter,c:GetControler(),LOCATION_ONFIELD,0,3,nil)
	end
end
function c511000234.spop(e,tp,eg,ep,ev,re,r,rp,c)
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g1=Duel.SelectMatchingCard(tp,c511000234.spfilter,tp,LOCATION_MZONE,0,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g2=Duel.SelectMatchingCard(tp,c511000234.spfilter,tp,LOCATION_ONFIELD,0,2,2,g1:GetFirst())
		g2:AddCard(g1:GetFirst())
		Duel.SendtoGrave(g2,REASON_COST)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c511000234.spfilter,tp,LOCATION_ONFIELD,0,3,3,nil)
		Duel.SendtoGrave(g,REASON_COST)
	end
end
function c511000234.atkdefval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsType,c:GetControler(),LOCATION_GRAVE,0,nil,TYPE_TRAP)*1000
end
function c511000234.trapdesfilter(c)
	return c:IsFacedown() and c:IsDestructable()
end
function c511000234.trapdestg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(1-tp) and c511000234.trapdesfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000234.trapdesfilter,tp,0,LOCATION_SZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c511000234.trapdesfilter,tp,0,LOCATION_SZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetChainLimit(c511000234.chainlimit)
end
function c511000234.chainlimit(e,rp,tp)
	return not e:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c511000234.trapdesop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFacedown() and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c511000234.spr(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ph=Duel.GetCurrentPhase()
	if not c:IsReason(REASON_BATTLE+REASON_EFFECT) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000234,1))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	if Duel.GetTurnPlayer()==tp and ph==PHASE_MAIN1 then
		e1:SetLabel(Duel.GetTurnCount())
		e1:SetCondition(c511000234.risecon2)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_MAIN1+RESET_SELF_TURN,2)
	else
		e1:SetCondition(c511000234.risecon)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_MAIN1+RESET_SELF_TURN,1)
	end
	e1:SetCost(c511000234.risecost)
	e1:SetTarget(c511000234.risetarget)
	e1:SetOperation(c511000234.riseop)
	c:RegisterEffect(e1)
end
function c511000234.trapfilter(c)
	return c:IsType(TYPE_TRAP) and c:IsDiscardable()
end
function c511000234.risecon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_DESTROY)
end
function c511000234.risecon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_DESTROY) and Duel.GetTurnCount()~=e:GetLabel()
end
function c511000234.risecost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000234.trapfilter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
	Duel.DiscardHand(tp,c511000234.trapfilter,1,1,REASON_COST+REASON_DISCARD)
end
function c511000234.risetarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,1,tp,true,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511000234.atcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)>1
end
function c511000234.riseop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SpecialSummon(c,1,tp,tp,true,false,POS_FACEUP)>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_TRIGGER)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_ATTACK)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetCondition(c511000234.atcon)
		c:RegisterEffect(e2)
	end
end
