--Scripted by Eerie Code
--Kuriball
function c6620.initial_effect(c)
	--ritual material
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_EXTRA_RITUAL_MATERIAL)
	c:RegisterEffect(e0)
	--Change position
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6620,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c6620.condition)
	e1:SetCost(c6620.cost)
	e1:SetTarget(c6620.target)
	e1:SetOperation(c6620.operation)
	c:RegisterEffect(e1)
end

function c6620.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:GetControler()~=tp
end
function c6620.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c6620.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() and tg:IsPosition(POS_ATTACK) end
end
function c6620.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENCE)
	end
end