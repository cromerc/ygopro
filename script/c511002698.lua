--Brilliant Shrine Art
function c511002698.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002698.condition)
	e1:SetTarget(c511002698.target)
	c:RegisterEffect(e1)
	--change target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000136,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511002698.atkcon)
	e2:SetTarget(c511002698.atktg)
	e2:SetOperation(c511002698.atkop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetCondition(c511002698.descon)
	e3:SetOperation(c511002698.desop)
	c:RegisterEffect(e3)
end
function c511002698.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x21)
end
function c511002698.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002698.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002698.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local a=Duel.GetAttacker()
	if Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and c511002698.atkcon(e,tp,Group.FromCards(a),ep,ev,re,r,rp) 
		and c511002698.atktg(e,tp,Group.FromCards(a),ep,ev,re,r,rp,0) and Duel.SelectYesNo(tp,aux.Stringid(61965407,1)) then
		e:SetOperation(c511002698.atkop)
		c511002698.atktg(e,tp,Group.FromCards(a),ep,ev,re,r,rp,1)
	else
		e:SetOperation(nil)
	end
end
function c511002698.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511002698.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002698.cfilter,tp,LOCATION_MZONE,0,1,Duel.GetAttackTarget()) end
end
function c511002698.atkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c511002698.cfilter,tp,LOCATION_MZONE,0,1,1,Duel.GetAttackTarget())
	if g:GetCount()>0 then
		Duel.ChangeAttackTarget(g:GetFirst())
	end
end
function c511002698.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsSetCard,1,nil,0x21)
end
function c511002698.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
