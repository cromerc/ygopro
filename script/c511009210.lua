--Labyrinth of Decisions
--Scripted by eclair11
function c511009210.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--send to grave
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLED)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511009210.condition)
	e2:SetCost(c511009210.cost)
	e2:SetTarget(c511009210.target)
	e2:SetOperation(c511009210.operation)
	c:RegisterEffect(e2)
end
function c511009210.condition(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget())
		or Duel.GetAttackTarget():IsControler(1-tp)
end
function c511009210.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,600) end
	Duel.PayLPCost(tp,600)
end
function c511009210.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,0,LOCATION_HAND)
end
function c511009210.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_TOGRAVE)
		local sg=g:Select(1-tp,1,1,nil)
		Duel.HintSelection(sg)
		Duel.SendtoGrave(sg,REASON_RULE)
	end
end