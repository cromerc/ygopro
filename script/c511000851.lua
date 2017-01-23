--Synchro Destructor
function c511000851.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c511000851.condition)
	e1:SetTarget(c511000851.target)
	e1:SetOperation(c511000851.activate)
	c:RegisterEffect(e1)
end
function c511000851.cfilter(c,tp)
	local rc=c:GetReasonCard()
	return c:IsReason(REASON_BATTLE) and rc:IsType(TYPE_SYNCHRO) and rc:IsControler(tp) and rc:IsRelateToBattle()
end
function c511000851.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000851.cfilter,1,nil,tp)
end
function c511000851.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(c511000851.cfilter,nil,tp)
	local tc=g:GetFirst()
	local dam=tc:GetTextAttack()/2
	if dam<0 then dam=0 end
	Duel.SetTargetPlayer(1-tp)
	if tc:IsType(TYPE_SYNCHRO) then
		Duel.SetTargetParam(dam*2)
	else
		Duel.SetTargetParam(dam)
	end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511000851.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
