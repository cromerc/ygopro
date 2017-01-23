--Earthbound God Aslla Piscu
function c511000239.initial_effect(c)
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e0:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e0:SetRange(LOCATION_MZONE)
	e0:SetTargetRange(1,0)
	e0:SetTarget(c511000239.sumlimit)
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
	e3:SetCondition(c511000239.havefieldcon)
	c:RegisterEffect(e3)
	--Unaffected by Spell and Trap Cards
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetCondition(c511000239.havefieldcon)
	e4:SetValue(c511000239.unaffectedval)
	c:RegisterEffect(e4)
	--Cannot be Battle Target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(1)
	e5:SetCondition(c511000239.havefieldcon)
	c:RegisterEffect(e5)
	--Destroy all Monsters and Inflict 800 Damage for Each Monster
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(511000239,0))
	e6:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_LEAVE_FIELD)
	e6:SetCondition(c511000239.descon)
	e6:SetTarget(c511000239.destg)
	e6:SetOperation(c511000239.desop)
	c:RegisterEffect(e6)
	--Self Destroy During the End Phase
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetProperty(CATEGORY_DESTROY)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCountLimit(1)
	e7:SetCode(EVENT_PHASE+PHASE_END)
	e7:SetCondition(c511000239.nofieldcon)
	e7:SetOperation(c511000239.nofieldop)
	c:RegisterEffect(e7)
	--direct attack
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_DIRECT_ATTACK)
	e10:SetRange(LOCATION_MZONE)
	e10:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e10:SetCondition(c511000239.havefieldcon)
	e10:SetTarget(c511000239.dirtg)
	c:RegisterEffect(e10)
end
function c511000239.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsSetCard(0x21)
end
function c511000239.dirfilter(c,card)
	return card~=c
end
function c511000239.dirtg(e,c)
	return not Duel.IsExistingMatchingCard(c511000239.dirfilter,c:GetControler(),0,LOCATION_MZONE,1,nil,e:GetHandler())
end
function c511000239.havefieldfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_FIELD)
end
function c511000239.havefieldcon(e)
	return Duel.IsExistingMatchingCard(c511000239.havefieldfilter,0,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler())
end
function c511000239.unaffectedval(e,te)
	return (te:IsActiveType(TYPE_SPELL) or te:IsActiveType(TYPE_TRAP)) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c511000239.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP) and not c:IsLocation(LOCATION_DECK)
		and Duel.IsExistingMatchingCard(c511000239.havefieldfilter,0,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler())
end
function c511000239.desfilter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c511000239.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c511000239.desfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	if g:GetCount()~=0 then
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*800)
	end
end
function c511000239.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511000239.desfilter,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct~=0 then
		Duel.BreakEffect()
		Duel.Damage(1-tp,ct*800,REASON_EFFECT)
	end
end
function c511000239.nofieldcon(e)
	local f1=Duel.GetFieldCard(0,LOCATION_SZONE,5)
	local f2=Duel.GetFieldCard(1,LOCATION_SZONE,5)
	return (f1==nil or not f1:IsFaceup()) and (f2==nil or not f2:IsFaceup())
end
function c511000239.nofieldop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
