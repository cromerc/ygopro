--Scandal Snapper
function c511002683.initial_effect(c)
	--lvup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(19012345,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511002683.condition)
	e1:SetOperation(c511002683.operation)
	c:RegisterEffect(e1)
end
function c511002683.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and e:GetHandler():GetLevel()<12
end
function c511002683.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetValue(2)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
	Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
end
