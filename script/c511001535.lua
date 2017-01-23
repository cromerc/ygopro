--Cyber Valkyrie
function c511001535.initial_effect(c)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_DAMAGE_CALCULATING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c511001535.atk)
	c:RegisterEffect(e2)
end
function c511001535.atk(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d or d:GetCode()~=511001535 or d:IsControler(1-tp) then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-300)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	a:RegisterEffect(e1)
end