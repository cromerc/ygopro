--無限の降魔鏡
function c100000080.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)	
	--SpecialSummon
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e2:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_REPEAT)
	e2:SetRange(LOCATION_SZONE)		
	e2:SetCondition(c100000080.regcon)
	e2:SetOperation(c100000080.operation)
	c:RegisterEffect(e2)	
	--SpecialSummon
	local e3=e2:Clone()
	e3:SetCondition(c100000080.regcon2)
	e3:SetOperation(c100000080.operation2)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_LEAVE_FIELD)
	e4:SetCondition(c100000080.spcon)	
	e4:SetOperation(c100000080.spopera)
	c:RegisterEffect(e4)	
end
function c100000080.cfilter(c)
	return c:IsFaceup() and c:GetCode()==100000081
end
function c100000080.regcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000080.cfilter,tp,LOCATION_MZONE,0,1,nil) and Duel.GetTurnPlayer()==tp and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
end
function c100000080.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local r=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if r<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,100000082,0,0x4011,3000,1000,10,RACE_FIEND,ATTRIBUTE_DARK) then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then r=1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	while r	do
		local token=Duel.CreateToken(tp,100000082)
		c:CreateRelation(token,RESET_EVENT+0x1fe0000)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		--battle indestructable
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		token:RegisterEffect(e1,true)	
		--CANNOT_DIRECT_ATTACK
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
		token:RegisterEffect(e2,true)
		--damage
		local e3=Effect.CreateEffect(c)
		e3:SetDescription(aux.Stringid(100000080,0))
		e3:SetCategory(CATEGORY_DAMAGE)
		e3:SetCode(EVENT_BATTLE_DESTROYING)
		e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e3:SetTarget(c100000080.damtg)
		e3:SetOperation(c100000080.damop)
		token:RegisterEffect(e3,true)
		Duel.SpecialSummonComplete()
		if r==0 then r=nil end
		if r~=nil then r=r-1 end		
	end
end
function c100000080.regcon2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000080.cfilter,tp,0,LOCATION_MZONE,1,nil) and Duel.GetTurnPlayer()~=tp and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0
end
function c100000080.operation2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local r=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if r<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,100000082,0,0x4011,3000,1000,10,RACE_FIEND,ATTRIBUTE_DARK) then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then r=1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	while r	do
		local token=Duel.CreateToken(tp,100000082)
		c:CreateRelation(token,RESET_EVENT+0x1fe0000)
		Duel.SpecialSummonStep(token,0,1-tp,1-tp,false,false,POS_FACEUP)
		--battle indestructable
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetValue(1)
		token:RegisterEffect(e1,true)	
		--CANNOT_DIRECT_ATTACK
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
		token:RegisterEffect(e2,true)
		--damage
		local e3=Effect.CreateEffect(c)
		e3:SetDescription(aux.Stringid(100000080,0))
		e3:SetCategory(CATEGORY_DAMAGE)
		e3:SetCode(EVENT_BATTLE_DESTROYING)
		e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e3:SetTarget(c100000080.damtg)
		e3:SetOperation(c100000080.damop)
		token:RegisterEffect(e3,true)
		Duel.SpecialSummonComplete()
		if r==0 then r=nil end
		if r~=nil then r=r-1 end		
	end
end
function c100000080.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(700)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,700)
end
function c100000080.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c100000080.tokendes(e)
	return not Duel.IsExistingMatchingCard(c100000080.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c100000080.cfilter2(c,tp,code)
	return c:IsCode(code) and c:IsReason(REASON_DESTROY)
end
function c100000080.cfilter3(c)
	return c:GetCode()==100000082 and c:IsDestructable()
end
function c100000080.spcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100000080.cfilter2,1,nil,tp,100000081) or eg:IsExists(c100000080.cfilter2,1,nil,1-tp,100000081) and  Duel.IsExistingMatchingCard(c100000080.cfilter3,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) 
end
function c100000080.spopera(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetMatchingGroup(c100000080.cfilter3,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.Destroy(sg,REASON_EFFECT)
end
