--Strains desmone
--scripted by andré
function c511004326.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c511004326.atkval)
	c:RegisterEffect(e1)
end
function c511004326.atkval(e,c)
	local atk=Duel.GetLP(1-c:GetControler())/2
	return atk
end