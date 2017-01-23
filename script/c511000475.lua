--Jirai Gumo (Anime)
function c511000475.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c511000475.target)
	e1:SetOperation(c511000475.activate)
	c:RegisterEffect(e1)
end
function c511000475.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:IsHasType(EFFECT_TYPE_ACTIVATE) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000475,0,0x21,2100,1000,4,RACE_INSECT,ATTRIBUTE_EARTH) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511000475.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511000475,0,0x21,2100,1000,4,RACE_INSECT,ATTRIBUTE_EARTH) then return end
	c:AddMonsterAttribute(TYPE_EFFECT+TYPE_TRAP)
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	c:AddMonsterAttributeComplete()
	--baseatk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetCondition(c511000475.basecon)
	e1:SetTarget(c511000475.basetg)
	e1:SetValue(c511000475.baseval)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
function c511000475.basecon(e)
	local ph=Duel.GetCurrentPhase()
	return (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) and Duel.GetAttackTarget()~=nil
		and (Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler())
end
function c511000475.basetg(e,c)
	return c==e:GetHandler():GetBattleTarget()
end
function c511000475.baseval(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler():GetBattleTarget()
	return c:GetBaseAttack()
end
