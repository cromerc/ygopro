--幻蝶の誘惑
function c511001028.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--must attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_MUST_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_EP)
	e3:SetRange(LOCATION_SZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(0,1)
	e3:SetCondition(c511001028.becon)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511001028,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetProperty(EFFECT_FLAG_REPEAT)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetCondition(c511001028.decon)
	e4:SetTarget(c511001028.destg)
	e4:SetOperation(c511001028.desop)
	c:RegisterEffect(e4)
end
function c511001028.becon(e)
	return Duel.IsExistingMatchingCard(Card.IsAttackable,Duel.GetTurnPlayer(),LOCATION_MZONE,0,1,nil)
end
function c511001028.desfilter(c)
	return c:IsFaceup() and c:GetAttackAnnouncedCount()==0 and c:IsDestructable()
end
function c511001028.decon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511001028.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c511001028.desfilter,Duel.GetTurnPlayer(),LOCATION_MZONE,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511001028.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c511001028.desfilter,Duel.GetTurnPlayer(),LOCATION_MZONE,0,e:GetHandler())
	Duel.Destroy(g,REASON_EFFECT)
end
