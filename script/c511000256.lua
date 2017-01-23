--The Seal of Orichalcos
function c511000256.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000256.actcost)
	e1:SetTarget(c511000256.acttg)
	e1:SetOperation(c511000256.actop)
	c:RegisterEffect(e1)
	--ATK Up
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetValue(500)
	c:RegisterEffect(e2)
	--Cannot Activate "Orichalcos Deuteros" in the Same Turn
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetCode(EFFECT_CANNOT_ACTIVATE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(1,1)
	e5:SetValue(c511000256.aclimit)
	c:RegisterEffect(e5)
	--cannot disable
	local e6=Effect.CreateEffect(c)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_CANNOT_DISABLE)
	c:RegisterEffect(e6)
	--
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCountLimit(1)
	e7:SetValue(c511000256.valcon)
	c:RegisterEffect(e7)
	--spsummon
	local e15=Effect.CreateEffect(c)
	e15:SetDescription(aux.Stringid(18326736,0))
	e15:SetType(EFFECT_TYPE_IGNITION)
	e15:SetRange(LOCATION_FZONE)
	e15:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e15:SetTarget(c511000256.tg)
	e15:SetOperation(c511000256.op)
	c:RegisterEffect(e15)
end
function c511000256.actcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,48179391)==0 end
	Duel.RegisterFlagEffect(tp,48179391,0,0,0)
end
function c511000256.valcon(e,re,r,rp)
    return bit.band(r,REASON_EFFECT)~=0
end
function c511000256.desfilter(c)
	return c:IsDestructable() and (c.hermos_filter or c.material_race or aux.IsMaterialListCode(c,1784686) 
		or aux.IsMaterialListCode(c,46232525) or aux.IsMaterialListCode(c,11082056) or c.material_trap)
end
function c511000256.mgfilter(c,code)
	return c:IsType(TYPE_TRAP) and code and c:IsCode(code)
end
function c511000256.mgfilter2(c,e,tp,fusc)
	return bit.band(c:GetReason(),0x40008)==0x40008 and c:IsType(TYPE_TRAP) and c:IsSSetable()
end
function c511000256.acttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c511000256.desfilter,tp,LOCATION_ONFIELD,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511000256.actop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c511000256.desfilter,tp,LOCATION_ONFIELD,0,nil)
	local sg=Group.CreateGroup()
	local tc=g:GetFirst()
	while tc do
		if tc:GetReasonEffect() then
			if tc:GetReasonEffect():GetHandler():IsCode(11082056) then
				local code=tc.material_trap
				local mc=Duel.GetFirstMatchingCard(c511000256.mgfilter,tp,LOCATION_GRAVE,0,nil,code)
				sg:AddCard(mc)
			elseif tc:GetReasonEffect():GetHandler():IsCode(1784686) then
				local mg=tc:GetMaterial()
				mg:Remove(Card.IsCode,nil,1784686)
				sg:Merge(mg)
			end
		end
		tc=g:GetNext()
	end
	Duel.Destroy(g,REASON_EFFECT)
	local mc=sg:GetFirst()
	while mc do
		if mc:IsType(TYPE_MONSTER) then
			Duel.MoveToField(mc,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
			mc:SetStatus(STATUS_SPSUMMON_TURN,true)
		else
			Duel.MoveToField(mc,tp,tp,LOCATION_MZONE,POS_FACEDOWN,true)
		end
	end
end
function c511000256.aclimit(e,re,tp)
	local rc=re:GetHandler()
	return not rc:IsCode(110000100) and rc:IsType(TYPE_FIELD) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
end
function c511000256.filter(c,tp)
	local seq=c:GetSequence()
	local mc=Duel.GetFieldCard(tp,LOCATION_MZONE,seq)
	local sc=Duel.GetFieldCard(tp,LOCATION_SZONE,seq)
	if c:GetFlagEffect(511000256)>0 then return false end
	if c:IsLocation(LOCATION_MZONE) then
		return not sc
	else
		return not mc and c:GetFlagEffect(511000257)>0
	end
end
function c511000256.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000256.filter,tp,LOCATION_ONFIELD,0,1,nil,tp) end
end
function c511000256.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,c511000256.filter,tp,LOCATION_ONFIELD,0,1,1,nil,tp):GetFirst()
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
			tc:RegisterFlagEffect(511000257,RESET_EVENT+0x1fe0000,0,0)
		end
		tc:RegisterFlagEffect(511000256,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
		Duel.MoveSequence(tc,seq)
		local e1=Effect.CreateEffect(tc)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fc0000)
		e1:SetValue(c511000256.val)
		tc:RegisterEffect(e1)
		Duel.RaiseEvent(tc,47408488,e,0,tp,0,0)
	end
end
function c511000256.val(e,c)
	if c:IsLocation(LOCATION_SZONE) then
		return TYPE_SPELL+TYPE_CONTINUOUS
	else
		return 0
	end
end
