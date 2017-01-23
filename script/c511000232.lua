--Number 3: Numeron Gate Trini
function c511000232.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,3)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLED)
	e1:SetCondition(c511000232.con)
	e1:SetCost(c511000232.cost)
	e1:SetTarget(c511000232.tg)
	e1:SetOperation(c511000232.op)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511000232.indes)
	c:RegisterEffect(e2)
end
c511000232.xyz_number=3
function c511000232.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil
end
function c511000232.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511000232.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1ff)
end
function c511000232.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000232.filter,tp,LOCATION_MZONE,0,1,nil) end
end
function c511000232.op(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511000232.filter,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_SET_ATTACK_FINAL)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetValue(tc:GetAttack()*2)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
function c511000232.indes(e,c)
	return not c:IsSetCard(0x48)
end
