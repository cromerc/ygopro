--Infernity Shield Bearer
function c511000626.initial_effect(c)
	--def
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetValue(800)
	e1:SetCondition(c511000626.defcon)
	c:RegisterEffect(e1)
end
function c511000626.defcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)==0
end
