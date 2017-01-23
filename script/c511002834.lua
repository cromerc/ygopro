--幻銃士
function c511002834.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(12958919,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511002834.sptg)
	e1:SetOperation(c511002834.spop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(12958919,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c511002834.damcost)
	e2:SetTarget(c511002834.damtg)
	e2:SetOperation(c511002834.damop)
	c:RegisterEffect(e2)
	Duel.AddCustomActivityCounter(511002834,ACTIVITY_ATTACK,c511002834.counterfilter)
end
function c511002834.counterfilter(c)
	return not c:IsCode(12958920)
end
function c511002834.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(nil,tp,LOCATION_MZONE,0,e:GetHandler())
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ct,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ct,0,0)
end
function c511002834.spop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(nil,tp,LOCATION_MZONE,0,e:GetHandler())
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>ct then ft=ct end
	if ft<ct then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,12958920,0x49,0x4011,500,500,4,RACE_FIEND,ATTRIBUTE_DARK) then return end
	for i=1,ft do
		local token=Duel.CreateToken(tp,12958920)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
function c511002834.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetCustomActivityCount(511002834,tp,ACTIVITY_ATTACK)==0 
		and c:GetAttackAnnouncedCount()==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetProperty(EFFECT_FLAG_OATH+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetTarget(c511002834.atklimit)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e2,true)
end
function c511002834.atklimit(e,c)
	return c:IsCode(12958920)
end
function c511002834.damfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x49) and c:IsRace(RACE_FIEND)
end
function c511002834.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ct=Duel.GetMatchingGroupCount(c511002834.damfilter,tp,LOCATION_MZONE,0,nil)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*300)
end
function c511002834.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ct=Duel.GetMatchingGroupCount(c511002834.damfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Damage(p,ct*300,REASON_EFFECT)
end
