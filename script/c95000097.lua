--Action Card - Flight
function c95000097.initial_effect(c)
--atk
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetTarget(c95000097.target)
	e1:SetOperation(c95000097.operation)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c95000097.handcon)
	c:RegisterEffect(e2)
end
function c95000097.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local at=eg:GetFirst()
	local a=Duel.GetAttacker()
	if chk==0 then return at:IsOnField() and at:IsFaceup() and a:IsOnField() end
	at:CreateEffectRelation(e)
end
function c95000097.operation(e,tp,eg,ep,ev,re,r,rp)
	local at=eg:GetFirst()
	if not at:IsRelateToEffect(e) or at:IsFacedown() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(600)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
	at:RegisterEffect(e1)
end

function c95000097.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end


