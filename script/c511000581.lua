--Despair Struggle
function c511000581.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511000581.condition)
	e1:SetTarget(c511000581.target)
	e1:SetOperation(c511000581.operation)
	c:RegisterEffect(e1)
end
function c511000581.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>0 and Duel.GetFieldGroupCount(tp,LOCATION_ONFIELD,0)<=1
end
function c511000581.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp) end
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,0)
end
function c511000581.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511000581.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	Duel.SetLP(tp,100,REASON_EFFECT)
	local ct=math.floor(Duel.GetBattleDamage(tp)/1000)
	Duel.Draw(tp,ct,REASON_EFFECT)
end
function c511000581.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
