--カオス・バースト
function c511002837.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511002837.condition)
	e1:SetCost(c511002837.cost)
	e1:SetTarget(c511002837.target)
	e1:SetOperation(c511002837.activate)
	c:RegisterEffect(e1)
end
function c511002837.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c511002837.cost(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c511002837.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	if chk==0 then return a:IsOnField() and a:IsDestructable() end
	Duel.SetTargetCard(a)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,a,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,a:GetAttack())
end
function c511002837.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local atk=tc:GetAttack()
	if atk<0 then atk=0 end
	if tc and tc:IsRelateToEffect(e) and tc:IsAttackable() and not tc:IsStatus(STATUS_ATTACK_CANCELED) and Duel.Destroy(tc,REASON_EFFECT)>0 then
		Duel.Damage(1-tp,atk,REASON_EFFECT)
	end
end