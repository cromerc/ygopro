--Number 28: Titanic Moth
function c511000512.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,2)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000512,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCondition(c511000512.condition)
	e1:SetCost(c511000512.cost)
	e1:SetTarget(c511000512.target)
	e1:SetOperation(c511000512.operation)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511000512.indes)
	c:RegisterEffect(e2)
end
c511000512.xyz_number=28
function c511000512.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil and Duel.GetAttacker()==e:GetHandler()
end
function c511000512.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511000512.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)>0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)*500)
end
function c511000512.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,Duel.GetFieldGroupCount(p,LOCATION_HAND,0)*500,REASON_EFFECT)
end
function c511000512.indes(e,c)
	return not c:IsSetCard(0x48)
end
