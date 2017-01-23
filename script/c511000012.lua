--Fenrir of the Nordic Wicked Wolves
function c511000012.initial_effect(c)  
	c:EnableUnsummonable()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e1:SetRange(LOCATION_HAND)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,1)
    e1:SetCondition(c511000012.spccon)
	e1:SetOperation(c511000012.spcop)
	c:RegisterEffect(e1)
	--Change Battle Pos
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000012,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c511000012.bptg)
	e3:SetOperation(c511000012.bpop)
	c:RegisterEffect(e3)
	--selfdes
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_SINGLE)
	e7:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCode(EFFECT_SELF_DESTROY)
	e7:SetCondition(c511000012.descon)
	c:RegisterEffect(e7)
	--damage
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e6:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e6:SetOperation(c511000012.damop)
	c:RegisterEffect(e6)
	--Cost
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SPSUMMON_COST)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCost(c511000012.spcost)
	e3:SetOperation(c511000012.spop)
	c:RegisterEffect(e3)
end
function c511000012.bptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(aux.TRUE,tp,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetFieldGroup(tp,aux.TRUE,tp,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,sg,sg:GetCount(),0,0)
end
function c511000012.bpop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetFieldGroup(tp,LOCATION_MZONE,nil)
	if sg:GetCount()>0 then
		Duel.ChangePosition(sg,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
function c511000012.desfilter(c)
	return c:IsFaceup() and (c:IsSetCard(0x42) or c:IsSetCard(0x4b))
end
function c511000012.descon(e)
	return not Duel.IsExistingMatchingCard(c511000012.desfilter,e:GetHandlerPlayer(),LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c511000012.sdcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_BATTLE)>0 and (Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler())
end
function c511000012.sdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-ep,ev,REASON_BATTLE)
end
function c511000012.spccon(e,c,tp)
	return Duel.GetActivityCount(tp,ACTIVITY_NORMALSUMMON)==0 and Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c511000012.spcop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_MSET)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BP)
	e3:SetTargetRange(1,0)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function c511000012.spcost(e,c,tp)
	return Duel.GetActivityCount(tp,ACTIVITY_NORMALSUMMON)==0 and Duel.GetCurrentPhase()==PHASE_MAIN1
end
function c511000012.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_MSET)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_BP)
	e3:SetTargetRange(1,0)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
end
function c511000012.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-ep,ev,false)
end
