--Ring of Fiendish Power
function c511001377.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c511001377.atlimit)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511001377.damcon)
	e3:SetTarget(c511001377.damtg)
	e3:SetOperation(c511001377.damop)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EFFECT_SELF_DESTROY)
	e4:SetCondition(c511001377.descon)
	c:RegisterEffect(e4)
end
function c511001377.filter(c,atk)
	return c:IsFaceup() and c:IsRace(RACE_FIEND) and c:GetBaseAttack()>atk
end
function c511001377.atlimit(e,c)
	return c:IsFacedown() or not c:IsRace(RACE_FIEND) 
		or Duel.IsExistingMatchingCard(c511001377.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,c,c:GetBaseAttack())
end
function c511001377.damcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsRace(RACE_FIEND)
end
function c511001377.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	local dam=bc:GetDefense()
	if dam<0 then dam=0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511001377.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511001377.desfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_FIEND)
end
function c511001377.descon(e)
	return not Duel.IsExistingMatchingCard(c511001377.desfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
