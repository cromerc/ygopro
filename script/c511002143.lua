--Yoshitsune the Goblin of Beauty
function c511002143.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(79409334,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetCondition(c511002143.condition)
	e1:SetTarget(c511002143.target)
	e1:SetOperation(c511002143.operation)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetCountLimit(1)
	e2:SetValue(c511002143.valcon)
	c:RegisterEffect(e2)
end
function c511002143.condition(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return a:IsControler(1-tp) and a:IsAttackAbove(1000)
end
function c511002143.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAttackPos() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c511002143.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsPosition(POS_FACEUP_ATTACK) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
function c511002143.valcon(e,re,r,rp)
	return e:GetHandler():IsDefensePos() and bit.band(r,REASON_BATTLE)~=0
end
