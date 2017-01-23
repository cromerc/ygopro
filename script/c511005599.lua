--Raft Party
--scripted by GameMaster(GM)
function c511005599.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511005599.target)
	e1:SetOperation(c511005599.activate)
	c:RegisterEffect(e1)
end
function c511005599.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511005600,0,0x4011,0,0,1,RACE_MACHINE,ATTRIBUTE_WATER) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c511005599.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>1 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511005600,0,0x4011,0,0,1,RACE_MACHINE,ATTRIBUTE_WATER) then
		for i=1,2 do
	local token=Duel.CreateToken(tp,511005600)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UNRELEASABLE_SUM)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511005599.sumlimit)
		token:RegisterEffect(e1,true)
		end
		Duel.SpecialSummonComplete()
	end
end
function c511005599.sumlimit(e,c)
	return not c:IsAttribute(ATTRIBUTE_WATER)
end
