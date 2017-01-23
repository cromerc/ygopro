--Klaret the Elite Magic Elf
function c511000853.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(c:GetAttack()*2)
	e1:SetCondition(c511000853.atkcon)
	c:RegisterEffect(e1)
end
function c511000853.atkcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_HAND)==0
end
