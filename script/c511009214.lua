--Metal Reflect Slime
--Scripted by eclair11
function c511009214.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511009214.condition)
	e1:SetTarget(c511009214.target)
	e1:SetOperation(c511009214.activate)
	c:RegisterEffect(e1)
end
function c511009214.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and ev>=Duel.GetLP(tp)+ev/2
end
function c511009214.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511009215,0,0x4011,0,-2,1,RACE_AQUA,ATTRIBUTE_WATER) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511009214.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511009215,0,0x4011,0,-2,1,RACE_AQUA,ATTRIBUTE_WATER) then return end
	local token=Duel.CreateToken(tp,511009215)
	Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_RACE)
	if tc:IsHasEffect(EFFECT_ADD_RACE) and not tc:IsHasEffect(EFFECT_CHANGE_RACE) then
		e1:SetValue(tc:GetOriginalRace())
	else
		e1:SetValue(tc:GetRace())
	end
	e1:SetReset(RESET_EVENT+0x1ff0000)
	token:RegisterEffect(e1,true)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	if tc:IsHasEffect(EFFECT_ADD_ATTRIBUTE) and not tc:IsHasEffect(EFFECT_CHANGE_ATTRIBUTE) then
		e2:SetValue(tc:GetOriginalAttribute())
	else
		e2:SetValue(tc:GetAttribute())
	end
	e2:SetReset(RESET_EVENT+0x1ff0000)
	token:RegisterEffect(e2,true)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SET_DEFENSE)
	e3:SetValue(tc:GetAttack()*3/4)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	token:RegisterEffect(e3,true)
	local e4=Effect.CreateEffect(e:GetHandler())
    e4:SetType(EFFECT_TYPE_SINGLE)
    e4:SetCode(EFFECT_CANNOT_ATTACK)
    e4:SetReset(RESET_EVENT+0x1fe0000)
    token:RegisterEffect(e4,true)
	Duel.SpecialSummonComplete()
end