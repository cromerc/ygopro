--Earthbound God Ccarayhua
function c511000263.initial_effect(c)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e0:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e0:SetRange(LOCATION_MZONE)
	e0:SetTargetRange(1,0)
	e0:SetTarget(c511000263.sumlimit)
	c:RegisterEffect(e0)
	local e1=e0:Clone()
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	c:RegisterEffect(e1)
	local e2=e0:Clone()
	e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	--Can Attack Directly
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	e3:SetCondition(c511000263.havefieldcon)
	c:RegisterEffect(e3)
	--Unaffected by Spell and Trap Cards
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetCondition(c511000263.havefieldcon)
	e4:SetValue(c511000263.unaffectedval)
	c:RegisterEffect(e4)
	--Cannot be Battle Target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(1)
	e5:SetCondition(c511000263.havefieldcon)
	c:RegisterEffect(e5)
	--Destroy all in Field
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(511000263,0))
	e6:SetCategory(CATEGORY_DESTROY)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetCondition(c511000263.havefieldcon)
	e6:SetTarget(c511000263.destg)
	e6:SetOperation(c511000263.desop)
	c:RegisterEffect(e6)
	--Self Destroy During the End Phase
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetCode(EVENT_PHASE+PHASE_END)
	e7:SetCondition(c511000263.nofieldcon)
	e7:SetOperation(c511000263.nofieldop)
	c:RegisterEffect(e7)
	--direct attack
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_DIRECT_ATTACK)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e10:SetCondition(c511000263.havefieldcon)
	e10:SetTarget(c511000263.dirtg)
	c:RegisterEffect(e10)
end
function c511000263.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsSetCard(0x21)
end
function c511000263.dirfilter(c,card)
	return card~=c
end
function c511000263.dirtg(e,c)
	return not Duel.IsExistingMatchingCard(c511000263.dirfilter,c:GetControler(),0,LOCATION_MZONE,1,nil,e:GetHandler())
end
function c511000263.havefieldfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_FIELD)
end
function c511000263.havefieldcon(e)
	return Duel.IsExistingMatchingCard(c511000263.havefieldfilter,0,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler())
end
function c511000263.unaffectedval(e,te)
	return (te:IsActiveType(TYPE_SPELL) or te:IsActiveType(TYPE_TRAP)) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c511000263.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReason(REASON_DESTROY) end
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511000263.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c511000263.nofieldcon(e)
	local f1=Duel.GetFieldCard(0,LOCATION_SZONE,5)
	local f2=Duel.GetFieldCard(1,LOCATION_SZONE,5)
	return (f1==nil or not f1:IsFaceup()) and (f2==nil or not f2:IsFaceup())
end
function c511000263.nofieldop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
