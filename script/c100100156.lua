--デス・アクセル
function c100100156.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c100100156.condition)
	e1:SetOperation(c100100156.operation)
	c:RegisterEffect(e1)
end
function c100100156.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c100100156.operation(e,tp,eg,ep,ev,re,r,rp)
	local d=math.floor(ev/300)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if not tc then return end
	tc:RegisterFlagEffect(100100103,RESET_EVENT+RESET_CHAIN,0,1)
	if (12-tc:GetCounter(0x91))<d then tc:AddCounter(0x91,12-tc:GetCounter(0x91))
	else tc:AddCounter(0x91,d) end
end
