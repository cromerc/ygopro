--Raidraptor - Evasive
function c511009319.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCost(c511009319.cost)
	e1:SetCondition(c511009319.condition)
	e1:SetOperation(c511009319.operation)
	c:RegisterEffect(e1)
end
function c511009319.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsPosition(POS_FACEUP) and tc:IsSetCard(0xba) and tc:IsType(TYPE_XYZ) and tc:GetOverlayCount()~=0
end
function c511009319.cfilter(c)
	return c:IsPosition(POS_FACEUP) and c:IsSetCard(0xba) and c:IsType(TYPE_XYZ) and c:GetOverlayCount()~=0
end
function c511009319.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	if chk==0 then return 
	tc:IsControler(tp) and tc:IsPosition(POS_FACEUP) and tc:IsSetCard(0xba) and tc:IsType(TYPE_XYZ) and tc:GetOverlayCount()~=0
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g1=tc:GetOverlayGroup()
	local mg2=g1:Select(tp,1,1,nil)
	Duel.SendtoHand(mg2,nil,REASON_COST)
end
function c511009319.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
