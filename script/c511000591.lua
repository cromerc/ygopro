--Shinato, King of a Higher Plane (DM)
--Scripted by edo9300
function c511000591.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--gain on damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetCondition(c511000591.effcon)
	e2:SetOperation(c511000591.revop)
	c:RegisterEffect(e2)
	--halve
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(c511000591.hvcon)
	e3:SetOperation(c511000591.hvop)
	c:RegisterEffect(e3)
	--Return
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c511000591.rtg)
	e4:SetOperation(c511000591.rop)
	c:RegisterEffect(e4)
	--splimit
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetRange(LOCATION_PZONE)
	e7:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetTargetRange(1,0)
	e7:SetTarget(c511000591.splimit)
	c:RegisterEffect(e7)
	--Immune
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_SINGLE)
	e8:SetCode(EFFECT_IMMUNE_EFFECT)
	e8:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e8:SetRange(LOCATION_PZONE)
	e8:SetValue(1)
	c:RegisterEffect(e8)
	if not c511000591.global_check then
		c511000591.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511000591.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511000591.dm=true
c511000591.dm_no_spsummon=true
c511000591.dm_no_activable=true
c511000591.dm_replace_original=true
function c511000591.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c511000591.effcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and e:GetHandler():GetFlagEffect(300)>0
end
function c511000591.revop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(tp,ev,REASON_EFFECT)
end
function c511000591.hvcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsFaceup() and e:GetHandler():IsRelateToBattle() and e:GetHandler():GetFlagEffect(300)>0
end
function c511000591.hvop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(1-tp,math.ceil(Duel.GetLP(1-tp)/2))
end
function c511000591.cfil(c,seq)
	local seq1=c:GetSequence()
	return seq==seq
end
function c511000591.rtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc1=Duel.GetFieldCard(e:GetHandlerPlayer(),LOCATION_SZONE,6)
	local tc2=Duel.GetFieldCard(e:GetHandlerPlayer(),LOCATION_SZONE,7)
	--Activate
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetReset(RESET_CHAIN)
	e:GetHandler():RegisterEffect(e2)
	if chk==0 then return e:GetHandler():CheckActivateEffect(false,false,false)~=nil and (not tc1 or not tc2) 
		and not e:GetHandler():IsStatus(STATUS_CHAINING) and e:GetHandler():GetFlagEffect(300)>0 end
end
function c511000591.rop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	local tpe=c:GetType()
	local te=c:GetActivateEffect()
	local tg=te:GetTarget()
	local co=te:GetCost()
	local op=te:GetOperation()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	Duel.ClearTargetCard()
	Duel.Hint(HINT_CARD,0,c:GetOriginalCode())
	c:CreateEffectRelation(te)
	if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
	if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
	Duel.BreakEffect()
	if op then op(te,tp,eg,ep,ev,re,r,rp) end
	c:ReleaseEffectRelation(te)
end
function c511000591.splimit(e,c,tp,sumtp,sumpos)
	return bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM
end