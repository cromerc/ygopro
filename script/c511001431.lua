--CNo.106 溶岩掌ジャイアント・ハンド・レッド
function c511001431.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,3)
	c:EnableReviveLimit()
	--Rank Up Check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511001431.rankupregcon)
	e1:SetOperation(c511001431.rankupregop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetValue(c511001431.damval)
	c:RegisterEffect(e2)
	if not c511001431.global_check then
		c511001431.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511001431.numchk)
		Duel.RegisterEffect(ge2,0)
	end
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c511001431.indes)
	c:RegisterEffect(e3)
	if not c511001431.global_check then
		c511001431.global_check=true
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_ADJUST)
		ge3:SetCountLimit(1)
		ge3:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge3:SetOperation(c511001431.numchk)
		Duel.RegisterEffect(ge3,0)
	end
end
c511001431.xyz_number=106

function c511001431.rumfilter(c)
	return c:IsCode(88177324) and not c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c511001431.rankupregcon(e,tp,eg,ep,ev,re,r,rp)
		local rc=re:GetHandler()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and (rc:IsSetCard(0x95) or rc:IsCode(100000581) or rc:IsCode(111011002) or rc:IsCode(511000580) or rc:IsCode(511002068) or rc:IsCode(511002164) or rc:IsCode(93238626)) and e:GetHandler():GetMaterial():IsExists(c511001431.rumfilter,1,nil)
end
function c511001431.rankupregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(55888045,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511001431.discon)
	e1:SetCost(c511001431.discost)
	e1:SetTarget(c511001431.distg)
	e1:SetOperation(c511001431.disop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
function c511001431.damval(e,re,val,r,rp,rc)
	if e:GetHandler():IsPosition(POS_FACEUP_ATTACK) and bit.band(r,REASON_EFFECT)~=0 then return 0
	else return val end
end
function c511001431.discon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,63746411)
end
function c511001431.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511001431.filter(c)
	return c:IsFaceup() and not c:IsDisabled()
end
function c511001431.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001431.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,e:GetHandler()) end
end
function c511001431.disop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511001431.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,e:GetHandler())
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
function c511001431.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,55888045)
	Duel.CreateToken(1-tp,55888045)
end
function c511001431.indes(e,c)
	return not c:IsSetCard(0x48)
end