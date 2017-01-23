--Rank Domination
function c511001866.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c511001866.atktarget)
	c:RegisterEffect(e2)
	--lowest first
	local e3=e2:Clone()
	e3:SetTarget(c511001866.atktarget2)
	c:RegisterEffect(e3)
	--lose atk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(c511001866.atktg)
	e4:SetValue(c511001866.atkval)
	c:RegisterEffect(e4)
end
function c511001866.atktarget(e,c)
	return c:GetRank()<=0
end
function c511001866.filter(c,rk)
	local atkct=c:GetEffectCount(EFFECT_EXTRA_ATTACK)+1
	return c:IsFaceup() and c:GetRank()>0 and c:GetRank()<rk and c:IsAttackable() and c:GetAttackedCount()<atkct
end
function c511001866.atktarget2(e,c)
	local rk=c:GetRank()
	local p=c:GetControler()
	return c:IsFaceup() and rk>0 and Duel.IsExistingMatchingCard(c511001866.filter,p,LOCATION_MZONE,0,1,nil,rk)
end
function c511001866.atktg(e,c)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a or not d or a:GetRank()<=0 or d:GetRank()<=0 or a:GetRank()==d:GetRank() then return false end
	if a:GetRank()>d:GetRank() then
		return c==d
	else
		return c==a
	end
end
function c511001866.atkval(e,c)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not a or not d or a:GetRank()<=0 or d:GetRank()<=0 or a:GetRank()==d:GetRank() then return 0 end
	if a:GetRank()>d:GetRank() then
		return (a:GetRank()-d:GetRank())*-1000
	else
		return (d:GetRank()-a:GetRank())*-1000
	end
end
