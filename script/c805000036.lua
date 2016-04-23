--桜姫タレイア
function c805000036.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c805000036.val)
	c:RegisterEffect(e1)
	--immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c805000036.etarget)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c805000036.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT)
end
function c805000036.val(e,c)
	return Duel.GetMatchingGroupCount(c805000036.filter,c:GetControler(),LOCATION_MZONE,0,nil)*100
end
function c805000036.etarget(e,c)
	return c:IsFaceup() and c:IsRace(RACE_PLANT) and c~=e:GetHandler()
end
