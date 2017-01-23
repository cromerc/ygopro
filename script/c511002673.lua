--ＥＭディスカバー・ヒッポ
function c511002673.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
