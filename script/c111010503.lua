--武装神竜プロテクト・ドラゴン
function c111010503.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetTarget(c111010503.indes)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--destroy equip
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(111010503,0))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_EQUIP)
	e2:SetTarget(c111010503.destg)
	e2:SetOperation(c111010503.desop)
	c:RegisterEffect(e2)
end
function c111010503.indes(e,c)
	return c:IsType(TYPE_SPELL+TYPE_EQUIP) 
end
function c111010503.filter(c,ec)
	return c:GetEquipTarget()==ec
end
function c111010503.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c111010503.filter,1,nil,e:GetHandler()) end
end
function c111010503.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(500)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
end
