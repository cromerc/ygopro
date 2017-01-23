--Heaven's Judgment
function c511002327.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002327.condition)
	e1:SetCost(c511002327.cost)
	e1:SetTarget(c511002327.target)
	e1:SetOperation(c511002327.activate)
	c:RegisterEffect(e1)
end
function c511002327.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511002327.costfilter(c,lv)
	return c:IsRace(RACE_FAIRY) and c:GetLevel()==lv and c:IsAbleToGraveAsCost()
end
function c511002327.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	if chk==0 then return Duel.IsExistingMatchingCard(c511002327.costfilter,tp,LOCATION_DECK,0,1,nil,a:GetLevel()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c511002327.costfilter,tp,LOCATION_DECK,0,1,1,nil,a:GetLevel())
	Duel.SendtoGrave(g,REASON_COST)
end
function c511002327.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() and tg:IsDestructable() end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
end
function c511002327.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsAttackable() and not tc:IsStatus(STATUS_ATTACK_CANCELED) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
