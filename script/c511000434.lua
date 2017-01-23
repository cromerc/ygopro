--Hexe Trude
function c511000434.initial_effect(c)
	--Atk up
	--Jackpro 1.3
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511000434.atkcon)
	e1:SetOperation(c511000434.atkop)
	c:RegisterEffect(e1)
end
function c511000434.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsRelateToBattle() and e:GetHandler():IsFaceup()
end
function c511000434.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToBattle() and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(400)
		c:RegisterEffect(e1)
	end
end
