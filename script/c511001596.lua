--デビルズ・サンクチュアリ
function c511001596.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001596.target)
	e1:SetOperation(c511001596.activate)
	c:RegisterEffect(e1)
end
function c511001596.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,24874631,0,0x4011,-2,0,1,RACE_FIEND,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511001596.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,24874631,0,0x4011,-2,0,1,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,24874631)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	local e0=Effect.CreateEffect(e:GetHandler())
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_SET_BASE_ATTACK)
	e0:SetValue(-2)
	e0:SetReset(RESET_EVENT+0xfe0000)
	token:RegisterEffect(e0)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	token:RegisterEffect(e1,true)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REFLECT_BATTLE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(1)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	token:RegisterEffect(e2,true)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCountLimit(1)
	e3:SetOperation(c511001596.rtcost)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	token:RegisterEffect(e3,true)
	local e4=Effect.CreateEffect(e:GetHandler())
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_UPDATE_ATTACK)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	e4:SetValue(Duel.GetLP(1-tp))
	token:RegisterEffect(e4)
end
function c511001596.rtcost(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetTurnPlayer()~=tp then return end
	if Duel.GetLP(tp)>1000 and Duel.SelectYesNo(tp,aux.Stringid(24874630,0)) then
		Duel.PayLPCost(tp,1000)
	else
		Duel.Destroy(e:GetHandler(),REASON_RULE)
	end
end
