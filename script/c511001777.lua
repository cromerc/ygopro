--CNo.43 魂魄傀儡鬼神カオス・マリオネッター
function c511001777.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),3,4)
	c:EnableReviveLimit()
	--Rank Up Check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511001777.rankupregcon)
	e1:SetOperation(c511001777.rankupregop)
	c:RegisterEffect(e1)
	--battle indestructable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetValue(c511001777.indes)
	c:RegisterEffect(e5)
	if not c511001777.global_check then
		c511001777.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511001777.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511001777.xyz_number=43
function c511001777.rumfilter(c)
	return c:IsCode(56051086) and not c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c511001777.rankupregcon(e,tp,eg,ep,ev,re,r,rp)
		local rc=re:GetHandler()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and (rc:IsSetCard(0x95) or rc:IsCode(100000581) or rc:IsCode(111011002) or rc:IsCode(511000580) or rc:IsCode(511002068) or rc:IsCode(511002164) or rc:IsCode(93238626)) and e:GetHandler():GetMaterial():IsExists(c511001777.rumfilter,1,nil)
end
function c511001777.rankupregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
		--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32446630,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511001777.spcon)
	e1:SetCost(c511001777.spcost)
	e1:SetTarget(c511001777.sptg)
	e1:SetOperation(c511001777.spop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsCode,32446631))
	e2:SetValue(1)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
	--Negates Battle Damage
   	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e3:SetCondition(c511001777.rdcon)
	e3:SetOperation(c511001777.rdop)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e3)
	--atk
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_EXTRA_ATTACK)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e4:SetTarget(aux.TargetBoolFunction(Card.IsCode,32446631))
	e4:SetValue(c511001777.atkval)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e4)
end
function c511001777.cfilter(c,lp)
	return c:IsFaceup() and c:GetAttack()>lp
end
function c511001777.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001777.cfilter,tp,0,LOCATION_MZONE,1,nil,Duel.GetLP(1-tp))
end
function c511001777.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511001777.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,32446631,0,0x4011,-2,-2,1,RACE_FIEND,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,LOCATION_MZONE)
end
function c511001777.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,32446631,0,0x4011,-2,-2,1,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,32446631)
	Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(Duel.GetLP(1-tp))
	e1:SetReset(RESET_EVENT+0x1fe0000)
	token:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE)
	token:RegisterEffect(e2)
	Duel.SpecialSummonComplete()
end
function c511001777.rdcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return (a:IsCode(32446631) or (d and d:IsCode(32446631))) and tp==ep
end
function c511001777.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
	local c=e:GetHandler()
	if ev>0 and tp==ep then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		e1:SetValue(ev)
		c:RegisterEffect(e1)
	end
end
function c511001777.atkval(e,c)
	return e:GetHandler():GetOverlayCount()-1
end
function c511001777.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,32446630)
	Duel.CreateToken(1-tp,32446630)
end
function c511001777.indes(e,c)
	return not c:IsSetCard(0x48)
end
