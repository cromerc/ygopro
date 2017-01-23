--Graveyard of Wandering Souls
function c511002267.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--token
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetOperation(c511002267.regop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetDescription(aux.Stringid(45894482,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_EVENT_PLAYER+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(511002267)
	e3:SetTarget(c511002267.sptg)
	e3:SetOperation(c511002267.spop)
	c:RegisterEffect(e3)
end
function c511002267.filter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsControler(tp) and c:IsPreviousLocation(LOCATION_MZONE)
end
function c511002267.regop(e,tp,eg,ep,ev,re,r,rp)
	if eg:IsExists(c511002267.filter,1,nil,tp) then
		Duel.RaiseSingleEvent(e:GetHandler(),511002267,e,r,rp,tp,0)
	end
	if eg:IsExists(c511002267.filter,1,nil,1-tp) then
		Duel.RaiseSingleEvent(e:GetHandler(),511002267,e,r,rp,1-tp,0)
	end
end
function c511002267.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,23116809,0,0x4011,100,100,1,RACE_PYRO,ATTRIBUTE_FIRE) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511002267.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,23116809,0,0x4011,100,100,1,RACE_PYRO,ATTRIBUTE_FIRE) then return end
	local token=Duel.CreateToken(tp,23116809)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UNRELEASABLE_SUM)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	token:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	token:RegisterEffect(e2)
end
