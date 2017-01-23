--灰塵王 アッシュ・ガッシュ
function c511002037.initial_effect(c)
	--lvup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(19012345,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511002037.condition)
	e1:SetOperation(c511002037.operation)
	c:RegisterEffect(e1)
end
function c511002037.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c511002037.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_LEVEL)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
end
