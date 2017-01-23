--Demiurge Ema
function c511000609.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c511000609.val)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000609,0))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetTarget(c511000609.tg)
	e2:SetOperation(c511000609.op)
	c:RegisterEffect(e2)
end
function c511000609.filter(c)
	return c:IsFaceup() and c:IsCode(511000608)
end
function c511000609.val(e,c)
	return Duel.GetMatchingGroupCount(c511000609.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)*800
end
function c511000609.desfilter(c)
	return c:IsFaceup() and c:IsCode(511000608) and c:IsDestructable()
end
function c511000609.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dg=Duel.GetMatchingGroup(c511000609.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
end
function c511000609.op(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetMatchingGroup(c511000609.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(dg,REASON_EFFECT)
end
