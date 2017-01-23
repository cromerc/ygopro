--Monster Chain
function c511000226.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000226.target)
	c:RegisterEffect(e1)
	--self destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c511000226.descon)
	c:RegisterEffect(e2)
	--cannot attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	c:RegisterEffect(e3)
	--remove counter
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000226,0))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetCondition(c511000226.remcon)
	e4:SetOperation(c511000226.remop)
	c:RegisterEffect(e4)
end
function c511000226.filter(c)
	return c:IsType(TYPE_MONSTER)
end
function c511000226.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000226.filter,tp,LOCATION_MZONE,0,1,nil) end
	local c=e:GetHandler()
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)
	c:AddCounter(0x1098,ct)
end
function c511000226.descon(e)
	return e:GetHandler():GetCounter(0x1098)==0
end
function c511000226.remcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and e:GetHandler():GetCounter(0x1098)~=0
end
function c511000226.remop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		c:RemoveCounter(tp,0x1098,1,REASON_EFFECT)
	end
end
