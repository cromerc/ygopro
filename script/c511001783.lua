--霧の王
function c511001783.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(35950025,0))
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c511001783.ntcon)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetCondition(c511001783.discon)
	e2:SetTarget(c511001783.distg)
	c:RegisterEffect(e2)
	--1 atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(14261867,1))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_TRIGGER_O+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetCondition(c511001783.atkcon)
	e3:SetOperation(c511001783.atkop)
	c:RegisterEffect(e3)
end
function c511001783.filter(c)
	return c:IsFaceup() and c:IsCode(111215001)
end
function c511001783.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:GetLevel()>4 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and (Duel.IsExistingMatchingCard(c511001783.filter,c:GetControler(),LOCATION_ONFIELD,0,1,nil)
		or Duel.IsEnvironment(111215001))
end
function c511001783.discon(e)
	return e:GetHandler():IsAttackPos()
end
function c511001783.distg(e,c)
	return c~=e:GetHandler()
end
function c511001783.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c==Duel.GetAttacker() and bc and bc:IsControler(1-tp)
end
function c511001783.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and bc then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE)
		e1:SetValue(1)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		bc:RegisterEffect(e2)
	end
end
