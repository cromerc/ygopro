--Toon Mask
function c511000915.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c511000915.cost)
	e1:SetCondition(c511000915.condition)
	e1:SetTarget(c511000915.target)
	e1:SetOperation(c511000915.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c511000915.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsType,1,nil,TYPE_TOON) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsType,1,1,nil,TYPE_TOON)
	Duel.Release(g,REASON_COST)
end
function c511000915.cfilter(c,tp)
	return c:GetSummonPlayer()==1-tp 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetCode(),0,0x4011,c:GetAttack(),c:GetDefense(),c:GetLevel(),c:GetRace(),c:GetAttribute())
end
function c511000915.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000915.cfilter,1,nil,tp)
end
function c511000915.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetTargetCard(eg)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511000915.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=eg:Filter(c511000915.cfilter,nil,tp)
	local tc=g:GetFirst()
	if not tc then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,tc:GetCode(),0,0x4011,tc:GetAttack(),tc:GetDefense(),tc:GetLevel(),tc:GetRace(),tc:GetAttribute()) then return end	
	if g:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		tc=g:Select(tp,1,1,nil):GetFirst()
	end
	local token=Duel.CreateToken(tp,tc:GetCode())
	if Duel.SpecialSummonStep(token,0,tp,tp,true,false,POS_FACEUP)~=0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_TYPE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CLIENT_HINT)
		e1:SetValue(tc:GetType()+TYPE_TOON)
		e1:SetDescription(aux.Stringid(511000915,0))
		e1:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e1)
		--destroy
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EVENT_LEAVE_FIELD)
		e3:SetCondition(c511000915.sdescon)
		e3:SetOperation(c511000915.sdesop)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e3)
		--direct attack
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_DIRECT_ATTACK)
		e4:SetCondition(c511000915.dircon)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e4)
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_FIELD)
		e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
		e5:SetRange(LOCATION_MZONE)
		e5:SetTargetRange(0,LOCATION_MZONE)
		e5:SetTarget(c511000915.attg)
		e5:SetCondition(c511000915.atcon)
		e5:SetValue(c511000915.atval)
		e5:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e5)
		local e6=Effect.CreateEffect(c)
		e6:SetType(EFFECT_TYPE_SINGLE)
		e6:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
		e6:SetCondition(c511000915.atcon)
		e6:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e6)
		Duel.SpecialSummonComplete()
	end
end
function c511000915.sfilter(c)
	return c:IsReason(REASON_DESTROY) and c:IsCode(15259703) and c:IsPreviousLocation(LOCATION_ONFIELD)
end
function c511000915.sdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000915.sfilter,1,nil)
end
function c511000915.sdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c511000915.atkfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_TOON)
end
function c511000915.dircon(e)
	return not Duel.IsExistingMatchingCard(c511000915.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c511000915.atcon(e)
	return Duel.IsExistingMatchingCard(c511000915.atkfilter,e:GetHandlerPlayer(),0,LOCATION_MZONE,1,nil)
end
function c511000915.attg(e,c)
	return not c:IsType(TYPE_TOON)
end
function c511000915.atval(e,c)
	return c==e:GetHandler()
end
