--クリアー・バイス・ドラゴン
function c513000096.initial_effect(c)
	--remove att
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_REMOVE_ATTRIBUTE)
	e1:SetValue(ATTRIBUTE_DARK)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c513000096.atkcon)
	e2:SetValue(c513000096.atkval)
	c:RegisterEffect(e2)
	--to defense
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c513000096.poscon)
	e3:SetOperation(c513000096.posop)
	c:RegisterEffect(e3)
	--Destroy replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_DESTROY_REPLACE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTarget(c513000096.desreptg)
	c:RegisterEffect(e4)
	--Negate
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(12298909,0))
	e5:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e5:SetCode(EVENT_CHAINING)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCondition(c513000096.discon)
	e5:SetCost(c513000096.discost)
	e5:SetTarget(c513000096.distg)
	e5:SetOperation(c513000096.disop)
	c:RegisterEffect(e5)
end
function c513000096.atkcon(e)
	return Duel.GetCurrentPhase()==PHASE_DAMAGE_CAL
		and Duel.GetAttacker()==e:GetHandler() and Duel.GetAttackTarget()~=nil
end
function c513000096.atkval(e,c)
	return Duel.GetAttackTarget():GetAttack()*2
end
function c513000096.poscon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetAttackedCount()>0
end
function c513000096.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsAttackPos() then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
function c513000096.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	if chk==0 then return c:IsReason(REASON_BATTLE) and c:IsFaceup() and g:GetCount()>0 end
	if Duel.SelectYesNo(tp,aux.Stringid(511000174,0)) then
		Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
		return true
	else return false end
end
function c513000096.discon(e,tp,eg,ep,ev,re,r,rp)
	if e==re or e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) or not Duel.IsChainNegatable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tg:IsContains(e:GetHandler())
end
function c513000096.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD,nil)
end
function c513000096.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c513000096.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
