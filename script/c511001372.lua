--Number C88: Gimmick Puppet Disaster Leo (Anime)
function c511001372.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,9,4)
	c:EnableReviveLimit()
	--Rank Up Check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511001372.rankupregcon)
	e1:SetOperation(c511001372.rankupregop)
	c:RegisterEffect(e1)
	--immunity
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetValue(c511001372.efilter)
	c:RegisterEffect(e2)
	--battle indestructable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetValue(c511001372.indes)
	c:RegisterEffect(e5)
	if not c511001372.global_check then
		c511001372.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511001372.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511001372.xyz_number=88
function c511001372.rumfilter(c)
	return c:IsCode(48995978) and not c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c511001372.rankupregcon(e,tp,eg,ep,ev,re,r,rp)
		local rc=re:GetHandler()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and (rc:IsSetCard(0x95) or rc:IsCode(100000581) or rc:IsCode(111011002) or rc:IsCode(511000580) or rc:IsCode(511002068) or rc:IsCode(511002164) or rc:IsCode(93238626)) and e:GetHandler():GetMaterial():IsExists(c511001372.rumfilter,1,nil)
end
function c511001372.rankupregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
		--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(6165656,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCost(c511001372.cost)
	e3:SetTarget(c511001372.target)
	e3:SetOperation(c511001372.operation)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e3)
	--win
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_DELAY)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetCountLimit(1)
	e4:SetOperation(c511001372.winop)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e4)
end
function c511001372.efilter(e,te)
	return te:IsActiveType(TYPE_MONSTER) and te:GetOwner()~=e:GetOwner()
end
function c511001372.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511001372.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(4000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,4000)
end
function c511001372.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511001372.winop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetOverlayCount()==0 then
		local WIN_REASON_DISASTER_LEO=0x18
		Duel.Win(tp,WIN_REASON_DISASTER_LEO)
	end
end
function c511001372.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,6165656)
	Duel.CreateToken(1-tp,6165656)
end
function c511001372.indes(e,c)
	return not c:IsSetCard(0x48)
end
