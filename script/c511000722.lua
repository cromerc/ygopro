--Bacchus Banquet
function c511000722.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000722.condition)
	c:RegisterEffect(e1)
	--selfdestroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c511000722.descon)
	c:RegisterEffect(e2)
	--Deflect
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPSUMMON)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511000722.con)
	e3:SetOperation(c511000722.op)
	c:RegisterEffect(e3)
end
function c511000722.con(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and eg:GetFirst():GetLevel()<=7
end
function c511000722.op(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c511000722.cfilter(c)
	return c:IsFaceup() and c:IsCode(511000720)
end
function c511000722.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511000722.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511000722.descon(e)
	return not Duel.IsExistingMatchingCard(c511000722.cfilter,e:GetHandler():GetControler(),LOCATION_ONFIELD,0,1,nil)
end
