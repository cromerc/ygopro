--Divine Serpent Geh
function c170000170.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--infinite
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetCondition(c170000170.damcon)
	e2:SetOperation(c170000170.damop)
	c:RegisterEffect(e2)
	--spsummon success
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetOperation(c170000170.sucop)
	c:RegisterEffect(e4)
	--attack cost
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_ATTACK_COST)
	e5:SetCost(c170000170.atcost)
	e5:SetOperation(c170000170.atop)
	c:RegisterEffect(e5)
	--
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e8:SetCode(EFFECT_CANNOT_LOSE_LP)
	e8:SetRange(LOCATION_MZONE)
	e8:SetTargetRange(1,0)
	e8:SetValue(1)
	c:RegisterEffect(e8)
	local e9=e8:Clone()
	e9:SetCode(EFFECT_CANNOT_LOSE_DECK)
	c:RegisterEffect(e9)
	local e10=e8:Clone()
	e10:SetCode(EFFECT_CANNOT_LOSE_EFFECT)
	c:RegisterEffect(e10)
	--atk
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_SINGLE)
	e11:SetCode(EFFECT_UPDATE_ATTACK)
	e11:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e11:SetRange(LOCATION_MZONE)
	e11:SetValue(9999999)
	c:RegisterEffect(e11)
end
function c170000170.sucop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
	Duel.SendtoGrave(g,REASON_EFFECT)
	Duel.SetLP(tp,0)
end
function c170000170.damcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and e:GetHandler():GetAttack()>999999
end
function c170000170.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,Duel.GetLP(ep)*100)
end
function c170000170.atcost(e,c,tp)
	return Duel.IsPlayerCanDiscardDeckAsCost(tp,10)
end
function c170000170.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(tp,10,REASON_COST)
end
