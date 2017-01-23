--Hamon, Emperor of Descending Thunder
function c511000246.initial_effect(c)
	c:EnableReviveLimit()
	c:SetUniqueOnField(1,0,511000246)
	--Cannot Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511000246.spcon)
	e2:SetOperation(c511000246.spop)
	c:RegisterEffect(e2)
	--1000 Damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000246,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCondition(c511000246.dmgcon)
	e3:SetTarget(c511000246.dmgtg)
	e3:SetOperation(c511000246.dmgop)
	c:RegisterEffect(e3)
	--Protect other Monsters
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,0)
	e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e4:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e4:SetCondition(c511000246.protectcon)
	e4:SetTarget(c511000246.protecttg)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--Damage 0 for the rest of Turn
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511000246,1))
	e5:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e5:SetCode(EVENT_TO_GRAVE)
	e5:SetCondition(c511000246.nodmgcon)
	e5:SetOperation(c511000246.nodmgop)
	c:RegisterEffect(e5)
end
function c511000246.spfilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToGraveAsCost()
end
function c511000246.spcon(e,c)
	if c==nil then return true end
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)==0 then
		return Duel.IsExistingMatchingCard(c511000246.spfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
			and Duel.IsExistingMatchingCard(c511000246.spfilter,c:GetControler(),LOCATION_ONFIELD,0,3,nil)
	else
		return Duel.IsExistingMatchingCard(c511000246.spfilter,c:GetControler(),LOCATION_ONFIELD,0,3,nil)
	end
end
function c511000246.spop(e,tp,eg,ep,ev,re,r,rp,c)
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)==0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g1=Duel.SelectMatchingCard(tp,c511000246.spfilter,tp,LOCATION_MZONE,0,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g2=Duel.SelectMatchingCard(tp,c511000246.spfilter,tp,LOCATION_ONFIELD,0,2,2,g1:GetFirst())
		g2:AddCard(g1:GetFirst())
		Duel.SendtoGrave(g2,REASON_COST)
	else
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c511000246.spfilter,tp,LOCATION_ONFIELD,0,3,3,nil)
		Duel.SendtoGrave(g,REASON_COST)
	end
end
function c511000246.dmgcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle()	and bc:IsLocation(LOCATION_GRAVE) and bc:IsReason(REASON_BATTLE) and bc:IsType(TYPE_MONSTER)
end
function c511000246.dmgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c511000246.dmgop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511000246.protectcon(e)
	return e:GetHandler():IsDefensePos()
end
function c511000246.protecttg(e,c)
	return c~=e:GetHandler()
end
function c511000246.nodmgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousPosition(POS_FACEUP_DEFENSE) and e:GetHandler():IsReason(REASON_DESTROY)
end
function c511000246.nodmgop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
