--Carat Idol
--Scripted by GameMaster(GM)
function c511005597.initial_effect(c)
--target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c511005597.con)
	e1:SetTarget(c511005597.tglimit)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--Destroy all Monsters and Inflict 800 Damage for Each Monster
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511005597,0))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511005597.descon)
	e2:SetTarget(c511005597.destg)
	e2:SetOperation(c511005597.desop)
	c:RegisterEffect(e2)
	--check
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetOperation(c511005597.chkop)
	c:RegisterEffect(e3)
end
function c511005597.desfilter(c,g,pg)
	return c:IsFaceup() and c:GetAttack()>=1500 and c:IsDestructable()
end
function c511005597.filter2(c)
	return c:IsFacedown() and c:IsAttackAbove(1500) and c:IsDestructable()
end
function c511005597.con(e)
	return e:GetHandler():IsDefensePos()
end
function c511005597.tglimit(e,c)
	return c~=e:GetHandler()
end
function c511005597.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP) and not c:IsLocation(LOCATION_DECK)
		and Duel.IsExistingMatchingCard(c511005597.havefieldfilter,0,LOCATION_SZONE,LOCATION_SZONE,1,e:GetHandler())
end
function c511005597.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c511005597.desfilter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	end
function c511005597.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511005597.desfilter,tp,0,LOCATION_MZONE,nil)
	local ct=Duel.Destroy(g,REASON_EFFECT)
end
function c511005597.chkop(e,tp,eg,ep,ev,re,r,rp)
	local conf=Duel.GetFieldGroup(tp,0,LOCATION_MZONE,POS_FACEDOWN)
	if conf:GetCount()>0 then
		Duel.ConfirmCards(tp,conf)
	end
end
