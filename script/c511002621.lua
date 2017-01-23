--おう国こく
function c511002621.initial_effect(c)
	--Activate	
	local e1=Effect.CreateEffect(c)	
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(0x5f)
	e1:SetOperation(c511002621.op)
	c:RegisterEffect(e1)
	--decrease tribute
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(72497366,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_SUMMON_PROC)
	e2:SetRange(LOCATION_REMOVED)
	e2:SetTargetRange(LOCATION_HAND,0)
	e2:SetCondition(c511002621.ntcon)
	c:RegisterEffect(e2)
	--cannot direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e3:SetRange(LOCATION_REMOVED)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	c:RegisterEffect(e3)
	--unaffectable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetRange(LOCATION_REMOVED)
	e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_IMMUNE_EFFECT)
	e6:SetValue(c511002621.ctcon2)
	c:RegisterEffect(e6)
	--destroy
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e9:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_DELAY)
	e9:SetCode(EVENT_DESTROYED)
	e9:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e9:SetRange(LOCATION_REMOVED)
	e9:SetCondition(c511002621.descon)
	e9:SetTarget(c511002621.destg)
	e9:SetOperation(c511002621.desop)
	c:RegisterEffect(e9)
	local e10=e2:Clone()
	e10:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e10)
	--cannot attack
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e12:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e12:SetRange(LOCATION_REMOVED)
	e12:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e12:SetCondition(c511002621.atkcon)
	e12:SetTarget(c511002621.atktg)
	c:RegisterEffect(e12)
	--check
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e13:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e13:SetCode(EVENT_ATTACK_ANNOUNCE)
	e13:SetRange(LOCATION_SZONE)
	e13:SetOperation(c511002621.checkop)
	e13:SetLabelObject(e2)
	c:RegisterEffect(e13)
	--
	local eb=Effect.CreateEffect(c)
	eb:SetType(EFFECT_TYPE_SINGLE)
	eb:SetCode(EFFECT_CANNOT_TO_DECK)
	eb:SetRange(LOCATION_REMOVED)
	c:RegisterEffect(eb)
	local ec=eb:Clone()
	ec:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(ec)
	local ed=eb:Clone()
	ed:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(ed)
	local ee=eb:Clone()
	ee:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(ee)
end
function c511002621.ctcon2(e,re)
	return re:GetHandler()~=e:GetHandler()
end
function c511002621.op(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_REMOVED,0,1,nil,511002621) then
		Duel.DisableShuffleCheck()
		Duel.SendtoDeck(c,nil,-2,REASON_RULE)
	else
		Duel.Remove(c,POS_FACEUP,REASON_RULE)
		Duel.Hint(HINT_CARD,0,511002621)
	end
	if c:GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end
function c511002621.ntcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c511002621.cfilter(c,tp)
	return c:IsReason(REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp
end
function c511002621.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002621.cfilter,1,nil,tp)
end
function c511002621.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=eg:Filter(c511002621.cfilter,nil,tp):GetSum(Card.GetAttack)/2
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(dam)
end
function c511002621.desop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511002621.atkcon(e)
	return e:GetHandler():GetFlagEffect(30606547)~=0
end
function c511002621.atktg(e,c)
	return c:GetFieldID()~=e:GetLabel()
end
function c511002621.checkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetFlagEffect(30606547)~=0 then return end
	local fid=eg:GetFirst():GetFieldID()
	e:GetHandler():RegisterFlagEffect(30606547,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	e:GetLabelObject():SetLabel(fid)
end
