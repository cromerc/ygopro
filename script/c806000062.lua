--ゴーストリック・ハウス
function c806000062.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c806000062.tglimit)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	e3:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c806000062.tglimit2)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CHANGE_DAMAGE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(1,1)
	e4:SetValue(c806000062.val)
	c:RegisterEffect(e4)
end
function c806000062.tglimit(e,c)
	return c:IsFacedown() and c:IsDefencePos()
end
function c806000062.tglimit2(e,c)
	return not Duel.IsExistingMatchingCard(Card.IsFaceup,Duel.GetTurnPlayer(),0,LOCATION_MZONE,1,nil)
end
function c806000062.val(e,re,dam,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then
		return dam/2
	else if Duel.GetAttacker():IsSetCard(0x8c) and Duel.GetAttacker():GetControler()==Duel.GetTurnPlayer() then
		return dam
	else return dam/2 end
	end
end
