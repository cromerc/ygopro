--Court Battle
--Scripted by Snrk
function c511008016.initial_effect(c)
	c:SetUniqueOnField(1,1,511008016)
	--tokens
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511008016.toktg)
	e1:SetOperation(c511008016.tokop)
	c:RegisterEffect(e1)
	--attach token
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_FZONE)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetCondition(c511008016.attcon)
	e2:SetTarget(c511008016.atttg)
	e2:SetOperation(c511008016.attop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCondition(c511008016.attcon2)
	e3:SetTarget(c511008016.atttg2)
	e3:SetOperation(c511008016.attop2)
	c:RegisterEffect(e3)
	--attach xyz
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCode(511008016)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCondition(c511008016.xattcon)
	e4:SetOperation(c511008016.xattop)
	c:RegisterEffect(e4)
	--leave
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_LEAVE_FIELD)
	e5:SetProperty(EFFECT_FLAG_DELAY)
	e5:SetOperation(c511008016.leaveop)
	c:RegisterEffect(e5)
end

--attach token
function c511008016.confil(c,p)
	return c:IsReason(REASON_BATTLE+REASON_EFFECT) and c:GetPreviousControler()~=p
end
function c511008016.attcon(e,tp,eg,ep,ev,re,r,rp)
	if re~=nil then if re:GetHandlerPlayer()~=tp then return false else return true end end
	if eg:Filter(c511008016.confil,nil,tp):GetCount()>1 then return false end
	return eg:IsExists(c511008016.confil,1,nil,tp,rp)
end
function c511008016.atttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511008016.tfil,tp,LOCATION_MZONE,0,1,nil)
		and eg:GetFirst():IsPreviousLocation(LOCATION_MZONE) end
end
function c511008016.attop(e,tp,eg,ep,ev,re,r,rp)
	local tok=Duel.GetMatchingGroup(c511008016.tfil,tp,LOCATION_MZONE,0,nil):GetFirst()
	local gdes=eg:Filter(c511008016.confil,nil,tp)
	if e:GetHandler():IsRelateToEffect(e) and gdes:GetCount()>0 and tok then
		Duel.Overlay(tok,gdes)
		Duel.RaiseEvent(tok,511008016,e,0,0,0,0)
	end
end
function c511008016.tfil(c)
	return c:IsCode(511008017) and c:IsFaceup()
end
function c511008016.attcon2(e,tp,eg,ep,ev,re,r,rp)
	return c511008016.attcon(e,1-tp,eg,ep,ev,re,r,rp)
end
function c511008016.atttg2(e,tp,eg,ep,ev,re,r,rp,chk)
	return c511008016.atttg(e,1-tp,eg,ep,ev,re,r,rp,chk)
end
function c511008016.attop2(e,tp,eg,ep,ev,re,r,rp)
	return c511008016.attop(e,1-tp,eg,ep,ev,re,r,rp)
end

--tokens
function c511008016.tokcheck(e)
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
	and Duel.IsPlayerCanSpecialSummonMonster(tp,511008017,0,0x4011,0,0,0,0,0)
	and Duel.IsPlayerCanSpecialSummonMonster(1-tp,511008017,0,0x4011,0,0,0,0,0)
end
function c511008016.toktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return c511008016.tokcheck end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c511008016.tokop(e,tp,eg,ep,ev,re,r,rp)
	c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if c511008016.tokcheck then
		local sToken=Duel.CreateToken(tp,511008017)
		local oToken=Duel.CreateToken(1-tp,511008017)
		Duel.SpecialSummonStep(sToken,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
		Duel.SpecialSummonStep(oToken,0,tp,1-tp,false,false,POS_FACEUP_DEFENSE)
		Duel.SpecialSummonComplete()
		--immune
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_IMMUNE_EFFECT)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetValue(c511008016.immfil)
		e1:SetReset(RESET_EVENT+0x47c0000)
		oToken:RegisterEffect(e1,true)
		--cannot be battle target
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
		e2:SetValue(aux.imval1)
		e2:SetReset(RESET_EVENT+0x47c0000)
		oToken:RegisterEffect(e2,true)
		--direct attack
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetCode(EFFECT_DIRECT_ATTACK)
		e3:SetRange(LOCATION_MZONE)
		e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e3:SetTarget(c511008016.dirtg)
		e3:SetReset(RESET_EVENT+0x47c0000)
		oToken:RegisterEffect(e3,true)
		--cannot be tributed
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_UNRELEASABLE_SUM)
		e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e4:SetValue(1)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		oToken:RegisterEffect(e4)
		local e5=e4:Clone()
		e5:SetCode(EFFECT_UNRELEASABLE_NONSUM)
		oToken:RegisterEffect(e5)
		--no type/attribute/level
		local e6=Effect.CreateEffect(c)
		e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e6:SetType(EFFECT_TYPE_SINGLE)
		e6:SetCode(EFFECT_CHANGE_RACE)
		e6:SetValue(0)
		oToken:RegisterEffect(e6)
		local e7=Effect.CreateEffect(c)
		e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e7:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		oToken:RegisterEffect(e7)
		oToken:SetStatus(STATUS_NO_LEVEL,true)
		--cannot change battle pos
		local e8=Effect.CreateEffect(c)
		e8:SetType(EFFECT_TYPE_SINGLE)
		e8:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e8:SetReset(RESET_EVENT+0x1fe0000)
		oToken:RegisterEffect(e8)
		--clone
		local e9=e1:Clone()
		sToken:RegisterEffect(e9,true)
		local e10=e2:Clone()
		sToken:RegisterEffect(e10,true)
		local e11=e3:Clone()
		sToken:RegisterEffect(e11,true)
		local e12=e4:Clone()
		sToken:RegisterEffect(e12,true)
		local e13=e5:Clone()
		sToken:RegisterEffect(e13,true)
		local e14=e6:Clone()
		sToken:RegisterEffect(e14,true)
		local e15=e7:Clone()
		sToken:RegisterEffect(e15,true)
		local e16=e8:Clone()
		sToken:RegisterEffect(e16,true)
		sToken:SetStatus(STATUS_NO_LEVEL,true)
	end
end
function c511008016.dirtg(e,c)
	return not Duel.IsExistingMatchingCard(c511008016.dirfil,c:GetControler(),0,LOCATION_MZONE,1,nil)
end
function c511008016.dirfil(c)
	return not c:IsCode(511008017)
end
function c511008016.immfil(e,te)
	return not te:GetOwner():IsCode(511008016)
end

--attach xyz
function c511008016.xattcon(e,tp,eg,ep,ev,re,r,rp)
	local tok1=Duel.GetMatchingGroup(c511008016.tfil,tp,LOCATION_MZONE,0,nil):GetFirst()
	local tct1=tok1:GetOverlayGroup():GetCount()
	local tok2=Duel.GetMatchingGroup(c511008016.tfil,1-tp,LOCATION_MZONE,0,nil):GetFirst()
	local tct2=tok2:GetOverlayGroup():GetCount()
	if tct1>2 then
		e:SetLabelObject(tok1)
		return true end
	if tct2>2 then
		e:SetLabelObject(tok2)
		return true end
	return false
end
function c511008016.xattop(e,tp,eg,ep,ev,re,r,rp)
	if not c:IsRelateToEffect(e) then return end
	local tok=e:GetLabelObject()
	local rp=tok:GetControler()
	local c=Duel.GetMatchingGroup(c511008016.tfil,rp,LOCATION_MZONE,0,nil):GetFirst()
	local cp=c:GetControler()
	if Duel.IsExistingMatchingCard(c511008016.xyzfil,cp,LOCATION_MZONE,0,1,nil) then
		local xg=Duel.GetMatchingGroup(c511008016.xyzfil,cp,LOCATION_MZONE,0,nil)
		if xg:GetCount()==0 then return end
		local og=c:GetOverlayGroup()
		local ogct=og:GetCount()
		while ogct>0 do
			Duel.Hint(HINT_SELECTMSG,cp,HINTMSG_TARGET)
			local xtg=xg:Select(cp,1,1,nil)
			Duel.Hint(HINT_SELECTMSG,cp,HINTMSG_TARGET)
			local sog=0
			if xg:GetCount()<2 then
				sog=og:Select(cp,ogct,ogct,nil)
			else
				sog=og:Select(cp,1,ogct,nil)
			end
			local xtgc=xtg:GetFirst()
			Duel.Overlay(xtgc,sog)
			Duel.RaiseSingleEvent(c,EVENT_DETACH_MATERIAL,e,0,0,0,0)
			ogct=ogct-sog:GetCount()
			local sogc=sog:GetFirst()
			while sogc do
				og:RemoveCard(sogc)
				sogc=sog:GetNext()
			end
		end
	end
	local cb=Duel.GetMatchingGroup(c511008016.cbfil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Destroy(cb,REASON_EFFECT)
end
function c511008016.cbfil(c)
	return c:IsCode(511008016) and c:IsFaceup()
end
function c511008016.xyzfil(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end

--leave
function c511008016.leaveop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsFacedown() then return end
	local tg=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_MZONE,LOCATION_MZONE,nil,511008017)
	local tc=tg:GetFirst()
	while tc do
		local og=tc:GetOverlayGroup()
		Duel.SendtoGrave(og,REASON_DESTROY)
		tc=tg:GetNext()
	end
	Duel.Destroy(tg,REASON_EFFECT)
end