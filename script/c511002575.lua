--Explosive Wall
function c511002575.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002575.condition)
	e1:SetTarget(c511002575.target)
	e1:SetOperation(c511002575.activate)
	c:RegisterEffect(e1)
	--Activate (graveyard)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c511002575.condition)
	e2:SetCost(c511002575.rmcost)
	e2:SetTarget(c511002575.rmtg)
	e2:SetOperation(c511002575.rmop)
	c:RegisterEffect(e2)
end
function c511002575.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511002575.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() and tg:IsDestructable() 
		and Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,2,0,0)
end
function c511002575.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc and tc:IsRelateToBattle() and tc:IsAttackable() and not tc:IsStatus(STATUS_ATTACK_CANCELED) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,LOCATION_MZONE,0,1,1,nil)
		g:AddCard(tc)
		if g:GetCount()>1 then
			Duel.HintSelection(g)
			Duel.Destroy(g,REASON_EFFECT)
		end
	end
end
function c511002575.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c511002575.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() and tg:IsAbleToRemove() 
		and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	Duel.SetTargetCard(tg)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,0,e:GetHandler())
	g:AddCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,g:GetCount(),0,0)
end
function c511002575.rmop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc and tc:IsRelateToBattle() and tc:IsAttackable() and not tc:IsStatus(STATUS_ATTACK_CANCELED) then
		local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,0,e:GetHandler())
		g:AddCard(tc)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
	end
end
