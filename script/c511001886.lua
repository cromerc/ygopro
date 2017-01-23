--Atlandis Invitation
function c511001886.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001886.condition)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(26920296,2))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetCondition(c511001886.descon)
	e2:SetTarget(c511001886.destg)
	e2:SetOperation(c511001886.desop)
	c:RegisterEffect(e2)
end
function c511001886.cfilter(c)
	local code=c:GetCode()
	local class=_G["c"..code]
	if class==nil then return false end
	local no=class.xyz_number
	return c:IsFaceup() and no and no==6 and c:IsSetCard(0x48)
end
function c511001886.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001886.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511001886.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511001886.desfilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:GetAttackedCount()==0 and c:IsDestructable()
end
function c511001886.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dg=Duel.GetMatchingGroup(c511001886.desfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,dg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dg:GetSum(Card.GetAttack))
end
function c511001886.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local dg=Duel.GetMatchingGroup(c511001886.desfilter,tp,0,LOCATION_MZONE,nil)
	if dg:GetCount()>0 and Duel.Destroy(dg,REASON_EFFECT)>0 then
		local sum=dg:GetSum(Card.GetPreviousAttackOnField)
		Duel.Damage(tp,sum,REASON_EFFECT)
	end
end
