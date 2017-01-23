--Phantom Knights Dark Gauntlet
function c511001975.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001975.target)
	e1:SetOperation(c511001975.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c511001975.handcon)
	c:RegisterEffect(e2)
end
function c511001975.handcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_ONFIELD,0)==0
end
function c511001975.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:IsHasType(EFFECT_TYPE_ACTIVATE) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,24212820,0x10db,0x21,300,600,4,RACE_WARRIOR,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511001975.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local c=e:GetHandler()
	if c:IsRelateToEffect(e)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,24212820,0x10db,0x21,300,600,4,RACE_WARRIOR,ATTRIBUTE_DARK) then
		c:AddMonsterAttribute(TYPE_EFFECT)
		Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP_DEFENSE)
		c:AddMonsterAttributeComplete()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetCondition(c511001975.atkcon)
		e1:SetValue(c511001975.atkval)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1,true)
	end
end
function c511001975.atkcon(e)
	return Duel.GetAttackTarget() and e:GetHandler()==Duel.GetAttackTarget()
end
function c511001975.atkval(e,c)
	return Duel.GetMatchingGroupCount(Card.IsSetCard,tp,LOCATION_GRAVE,0,nil,0x10db)*300
end
