--Utopia's Last Line of Defense 
--scripted by:urielkama
function c511004122.initial_effect(c)
--change position
local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511004122,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511004122.con2)
	e1:SetOperation(c511004122.op2)
	c:RegisterEffect(e1)
end
function c511004122.con2(e,tp,eg,ep,ev,re,r,rp)
	local bt=eg:GetFirst()
	return r~=REASON_BATTLE and bt:IsSetCard(0x107f)
end
function c511004122.op2(e,tp,eg,ep,ev,re,r,rp)
local bt=Duel.GetAttackTarget()
	if bt:IsRelateToBattle() and not bt:IsPosition(POS_FACEUP_DEFENSE) then
	Duel.ChangePosition(bt,POS_FACEUP_DEFENSE,REASON_EFFECT)
	end
end