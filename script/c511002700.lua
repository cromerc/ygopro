--Sand Doodlebug
function c511002700.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(80538728,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511002700.atcon)
	e1:SetOperation(c511002700.atop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(96470883,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511002700.destg)
	e2:SetOperation(c511002700.desop)
	c:RegisterEffect(e2)
	--direct attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e3)
end
function c511002700.envfilter(c)
	return c:IsFaceup() and c:IsCode(23424603)
end
function c511002700.atcon(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.IsEnvironment(23424603) or Duel.IsExistingMatchingCard(c511002700.envfilter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)) 
		and Duel.GetAttacker():IsControler(1-tp)
end
function c511002700.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c511002700.filter(c)
	return c:IsFaceup() and c:IsDestructable() and c:IsLevelBelow(3)
end
function c511002700.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c511002700.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local tg=g:GetMinGroup(Card.GetAttack)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
	end
end
function c511002700.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c511002700.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
