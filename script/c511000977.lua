--ＳｐSilent Burn
function c511000977.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000977.con)
	e1:SetTarget(c511000977.target)
	e1:SetOperation(c511000977.activate)
	c:RegisterEffect(e1)
end
function c511000977.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>3 and (Duel.GetTurnPlayer()~=tp or Duel.GetCurrentPhase()>PHASE_BATTLE)
end
function c511000977.filter(c)
	return c:GetAttackAnnouncedCount()<=0
end
function c511000977.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000977.filter,tp,LOCATION_MZONE,0,1,nil) end
	local dam=Duel.GetMatchingGroupCount(c511000977.filter,tp,LOCATION_MZONE,0,nil)*300
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	if dam>0 then Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam) end
end
function c511000977.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=Duel.GetMatchingGroupCount(c511000977.filter,tp,LOCATION_MZONE,0,nil)*300
	Duel.Damage(p,dam,REASON_EFFECT)
end
