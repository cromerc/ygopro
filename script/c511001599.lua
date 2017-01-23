--エトワール・サイバー
function c511001599.initial_effect(c)
	--atkdef up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79853073,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511001599.con)
	e1:SetOperation(c511001599.op)
	c:RegisterEffect(e1)
end
function c511001599.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil
end
function c511001599.op(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(600)
	e:GetHandler():RegisterEffect(e1)	
end
