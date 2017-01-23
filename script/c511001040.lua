--ドラゴン族・封印の壺
function c511001040.initial_effect(c)
	--attach
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511001040.condition)
	e1:SetOperation(c511001040.operation)
	c:RegisterEffect(e1)
	--detach
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHANGE_POS)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetOperation(c511001040.flipop)
	c:RegisterEffect(e2)
end
function c511001040.filter2(c,fid)
	return c:IsFaceup() and c:IsCode(50045299) and c:GetFieldID()<fid
end
function c511001040.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c511001040.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler(),e:GetHandler():GetFieldID())
end
function c511001040.filter(c)
	return c:IsRace(RACE_DRAGON) and c:IsFaceup() and not c:IsCode(50045299)
end
function c511001040.operation(e,tp,eg,ep,ev,re,r,rp)
	local wg=Duel.GetMatchingGroup(c511001040.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Overlay(e:GetHandler(),wg)
end
function c511001040.flipop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local og=c:GetOverlayGroup()
	Duel.SendtoGrave(og,REASON_RULE)
end
