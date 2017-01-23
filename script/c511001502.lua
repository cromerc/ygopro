--Trick Mirror
function c511001502.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511001502.condition)
	e1:SetTarget(c511001502.target)
	e1:SetOperation(c511001502.activate)
	c:RegisterEffect(e1)
end
function c511001502.condition(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_TRAP) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and rp~=tp
end
function c511001502.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=re:GetTarget()
	if chk==0 then return not tg or tg(e,tp,eg,ep,ev,re,r,rp,0) end
	e:SetCategory(re:GetCategory())
	e:SetProperty(re:GetProperty())
	e:SetLabelObject(re)
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1) end
end
function c511001502.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c511001502.repop)
	local te=e:GetLabelObject()
	if not te then return end
	local op=te:GetOperation()
	if op then op(e,tp,eg,ep,ev,re,r,rp) end
end
function c511001502.repop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():CancelToGrave(false)
end
