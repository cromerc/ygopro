--ギミック・ボックス
function c100000212.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)	
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c100000212.condition)
	e1:SetTarget(c100000212.target)
	e1:SetOperation(c100000212.activate)
	c:RegisterEffect(e1)
end
function c100000212.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>0
end
function c100000212.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,100000212,0,0x1,-2,0,8,RACE_MACHINE,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c100000212.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,100000212,0,0x1,-2,0,8,RACE_MACHINE,ATTRIBUTE_DARK) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c100000212.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	c:AddMonsterAttribute(TYPE_MONSTER+TYPE_TRAP)
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	c:AddMonsterAttributeComplete()
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SET_ATTACK)
	e2:SetValue(Duel.GetBattleDamage(tp))
	e2:SetReset(RESET_EVENT+0xfe0000)
	c:RegisterEffect(e2)
end
function c100000212.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
