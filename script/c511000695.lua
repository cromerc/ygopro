--インセクト女王
function c511000695.initial_effect(c)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c511000695.value)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetOperation(c511000695.regop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000695,0))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetCountLimit(1)
	e4:SetCondition(c511000695.spcon)
	e4:SetTarget(c511000695.sptg)
	e4:SetOperation(c511000695.spop)
	c:RegisterEffect(e4)
end
function c511000695.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_INSECT)
end
function c511000695.value(e,c)
	return Duel.GetMatchingGroupCount(c511000695.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)*400
end
function c511000695.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(511000695,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511000695.spcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511000695)~=0
end
function c511000695.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511000695.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,511000696,0,0x4011,1200,0,4,RACE_INSECT,ATTRIBUTE_EARTH) then return end
	local token=Duel.CreateToken(tp,511000696)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP_ATTACK)
end
