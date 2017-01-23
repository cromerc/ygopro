--Power Throw
function c511000959.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCost(c511000959.cost)
	e1:SetCondition(c511000959.condition)
	e1:SetTarget(c511000959.target)
	e1:SetOperation(c511000959.activate)
	c:RegisterEffect(e1)
end
function c511000959.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsAttackBelow,1,nil,1000) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsAttackBelow,1,1,nil,1000)
	Duel.Release(g,REASON_COST)
	e:SetLabel(g:GetFirst():GetAttack())
end
function c511000959.cfilter(c,tp)
	local rc=c:GetReasonCard()
	return c:IsReason(REASON_BATTLE) and rc:GetBaseAttack()<=1000 and rc:IsControler(tp) and rc:IsRelateToBattle()
end
function c511000959.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000959.cfilter,1,nil,tp)
end
function c511000959.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel()*2)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel()*2)
end
function c511000959.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
