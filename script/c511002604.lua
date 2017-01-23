--オレイカルコスの結界
function c511002604.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	c:RegisterEffect(e1)
	--cannot disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_DISABLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetValue(500)
	c:RegisterEffect(e3)
	--cannot leave
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(e5)
	local e6=e4:Clone()
	e6:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(e6)
	local e7=e4:Clone()
	e7:SetCode(EFFECT_CANNOT_TO_DECK)
	c:RegisterEffect(e7)
	local e8=e4:Clone()
	e8:SetCode(EFFECT_CANNOT_TO_EXTRA)
	c:RegisterEffect(e8)
	local e9=e4:Clone()
	e9:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e9)
	local e10=e4:Clone()
	e10:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	c:RegisterEffect(e10)
	local e11=e4:Clone()
	e11:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	c:RegisterEffect(e11)
	local e12=e4:Clone()
	e12:SetCode(EFFECT_UNRELEASABLE_SUM)
	c:RegisterEffect(e12)
	local e13=e4:Clone()
	e13:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e13)
	--negate
	local e14=Effect.CreateEffect(c)
	e14:SetDescription(aux.Stringid(35952884,0))
	e14:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e14:SetType(EFFECT_TYPE_QUICK_O)
	e14:SetCode(EVENT_CHAINING)
	e14:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_CANNOT_DISABLE)
	e14:SetRange(LOCATION_HAND)
	e14:SetCondition(c511002604.discon)
	e14:SetCost(c511002604.discost)
	e14:SetTarget(c511002604.distg)
	e14:SetOperation(c511002604.disop)
	c:RegisterEffect(e14)
	--spsummon
	local e15=Effect.CreateEffect(c)
	e15:SetDescription(aux.Stringid(18326736,0))
	e15:SetType(EFFECT_TYPE_QUICK_O)
	e15:SetRange(LOCATION_FZONE)
	e15:SetCode(EVENT_FREE_CHAIN)
	e15:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e15:SetCost(c511002604.cost)
	e15:SetTarget(c511002604.tg)
	e15:SetOperation(c511002604.op)
	e15:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e15)
end
function c511002604.discon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsChainNegatable(ev)
end
function c511002604.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511002604.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c511002604.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c511002604.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(511002604)==0 end
	c:RegisterFlagEffect(511002604,RESET_CHAIN,0,1)
end
function c511002604.filter(c,tp)
	local seq=c:GetSequence()
	local mc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq)
	local sc=Duel.GetFieldCard(tp,LOCATION_SZONE,seq)
	if c:GetFlagEffect(511002604)>0 then return false end
	if c:IsLocation(LOCATION_MZONE) then
		return not sc
	else
		return not mc and c:GetFlagEffect(511002603)>0
	end
end
function c511002604.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002604.filter,tp,LOCATION_ONFIELD,0,1,nil,tp) end
end
function c511002604.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,c511002604.filter,tp,LOCATION_ONFIELD,0,1,1,nil,tp):GetFirst()
	if tc then
		local seq=tc:GetSequence()
		local loc=0
		if tc:IsLocation(LOCATION_MZONE) then
			loc=LOCATION_SZONE
		else
			loc=LOCATION_MZONE
		end
		local pos=0
		if tc:IsFaceup() then
			pos=POS_FACEUP
		elseif tc:IsLocation(LOCATION_SZONE) and tc:IsFacedown() then
			pos=POS_FACEDOWN_DEFENSE
		else
			pos=POS_FACEDOWN
		end
		Duel.MoveToField(tc,tp,tp,loc,pos,true)
		if tc:IsLocation(LOCATION_MZONE) then
			tc:SetStatus(STATUS_SPSUMMON_TURN,true)
		else
			tc:RegisterFlagEffect(511002603,RESET_EVENT+0x1fe0000,0,0)
		end
		tc:RegisterFlagEffect(511002604,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
		Duel.MoveSequence(tc,seq)
		local e1=Effect.CreateEffect(tc)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetCondition(c511002604.con)
		e1:SetValue(c511002604.val)
		tc:RegisterEffect(e1)
		Duel.RaiseEvent(tc,47408488,e,0,tp,0,0)
	end
end
function c511002604.con(e)
	return e:GetHandler():IsLocation(LOCATION_SZONE)
end
function c511002604.val(e,c)
	return TYPE_SPELL+TYPE_CONTINUOUS
end
