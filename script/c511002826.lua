--サイバネティック・ヒドゥン・テクノロジー
function c511002826.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002826.target)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(92773018,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCondition(c511002826.descon)
	e2:SetCost(c511002826.descost)
	e2:SetTarget(c511002826.destg)
	e2:SetOperation(c511002826.desop)
	c:RegisterEffect(e2)
	--destroy (hand)
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(17266660,0))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_HAND)
	e3:SetCost(c511002826.descost2)
	e3:SetTarget(c511002826.destg2)
	e3:SetOperation(c511002826.desop2)
	c:RegisterEffect(e3)
end
function c511002826.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local a=Duel.GetAttacker()
	if Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and c511002826.descon(e,tp,Group.FromCards(a),ep,ev,re,r,rp) 
		and c511002826.descost(e,tp,Group.FromCards(a),ep,ev,re,r,rp,0) and c511002826.destg(e,tp,Group.FromCards(a),ep,ev,re,r,rp,0) 
		and Duel.SelectYesNo(tp,aux.Stringid(92773018,1)) then
		e:SetCategory(CATEGORY_DESTROY)
		e:SetOperation(c511002826.desop)
		c511002826.descost(e,tp,Group.FromCards(a),ep,ev,re,r,rp,1)
		c511002826.destg(e,tp,Group.FromCards(a),ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetOperation(nil)
	end
end
function c511002826.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511002826.cfilter(c,x)
	return (x or c:IsFaceup()) and c:IsSetCard(0x93) and c:IsRace(RACE_MACHINE) and c:IsAbleToGraveAsCost()
end
function c511002826.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002826.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511002826.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511002826.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	if chk==0 then return a:IsOnField() and a:IsDestructable() end
	Duel.SetTargetCard(a)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,a,1,0,0)
end
function c511002826.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsAttackable() and not tc:IsStatus(STATUS_ATTACK_CANCELED) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
	Duel.BreakEffect()
	Duel.SkipPhase(1-tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
end
function c511002826.descost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() 
		and Duel.IsExistingMatchingCard(c511002826.cfilter,tp,LOCATION_HAND,0,1,c,true) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511002826.cfilter,tp,LOCATION_HAND,0,1,1,c,true)
	g:AddCard(c)
	Duel.SendtoGrave(g,REASON_COST)
end
function c511002826.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c511002826.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002826.filter,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511002826.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511002826.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c511002826.filter,tp,0,LOCATION_MZONE,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
