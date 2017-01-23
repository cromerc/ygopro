--Heavy Metal King
function c511009019.initial_effect(c)
	c:EnableReviveLimit()
	--spsummon proc
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_DECK)
	e1:SetCondition(c511009019.spcon)
	e1:SetOperation(c511009019.spop)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_CALCULATING)
	e2:SetCondition(c511009019.atkcon)
	e2:SetOperation(c511009019.atkop)
	c:RegisterEffect(e2)
end
function c511009019.spfilter(c)
	return c:IsCode(56907389) and c:GetEquipGroup():IsExists(Card.IsCode,1,nil,68540058)
end
function c511009019.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(tp,c511009019.spfilter,1,nil)
end
function c511009019.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(tp,c511009019.spfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
	Duel.ShuffleDeck(tp)
end
function c511009019.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker() and Duel.GetAttackTarget()~=nil
end
function c511009019.atkop(e,tp,eg,ep,ev,re,r,rp)
	local bc=Duel.GetAttackTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(bc:GetAttack()/2)
	e:GetHandler():RegisterEffect(e1)
end