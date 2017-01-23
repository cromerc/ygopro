--Boomerang Elf
function c511001508.initial_effect(c)
	--negate attack
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001508,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(TIMING_BATTLE_PHASE,0)
	e1:SetCondition(c511001508.atkcon)
	e1:SetTarget(c511001508.atktg)
	e1:SetOperation(c511001508.atkop)
	c:RegisterEffect(e1)
end
function c511001508.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker() and e:GetHandler()==Duel.GetAttacker() and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c511001508.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(nil,tp,0,LOCATION_MZONE,1,Duel.GetAttackTarget()) end
end
function c511001508.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(21558682,0))
	local g=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_MZONE,1,1,Duel.GetAttackTarget())
	if g:GetCount()>0 then
		Duel.ChangeAttackTarget(g:GetFirst())
	end
end
