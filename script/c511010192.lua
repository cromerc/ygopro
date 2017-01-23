--CNo.92 偽骸虚龍 Heart－eartH Chaos Dragon (Anime)
function c511010192.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,10,4)
	c:EnableReviveLimit()
	--Rank Up Check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511010192.rankupregcon)
	e1:SetOperation(c511010192.rankupregop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetLabel(0)
	c:RegisterEffect(e2)
	--recover
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511010192,0))
	e3:SetCategory(CATEGORY_RECOVER)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetLabelObject(e2)
	e3:SetCountLimit(1)
	e3:SetTarget(c511010192.rectg)
	e3:SetOperation(c511010192.recop)
	c:RegisterEffect(e3)
	--reset
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_ADJUST)
	e5:SetCountLimit(1)
	e5:SetRange(LOCATION_MZONE)
	e5:SetOperation(c511010192.reset)
	e5:SetLabelObject(e2)
	c:RegisterEffect(e5)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c511010192.indes)
	c:RegisterEffect(e6)
	if not c511010192.global_check then
		c511010192.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010192.numchk)
		Duel.RegisterEffect(ge2,0)
			--check
			local ge3=Effect.CreateEffect(c)
			ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			ge3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
			ge3:SetCode(EVENT_DAMAGE)
			ge3:SetCondition(c511010192.checkcon)
			ge3:SetOperation(c511010192.checkop)
			ge3:SetLabelObject(e2)
			Duel.RegisterEffect(ge3,0)
	end
end
c511010192.xyz_number=92
function c511010192.rumfilter(c)
	return c:IsCode(97403510) and not c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c511010192.rankupregcon(e,tp,eg,ep,ev,re,r,rp)
		local rc=re:GetHandler()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and (rc:IsSetCard(0x95) or rc:IsCode(100000581) or rc:IsCode(111011002) or rc:IsCode(511000580) or rc:IsCode(511002068) or rc:IsCode(511002164) or rc:IsCode(93238626)) and e:GetHandler():GetMaterial():IsExists(c511010192.rumfilter,1,nil)
end
function c511010192.rankupregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--negate
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511010192,1))
	e4:SetCategory(CATEGORY_DISABLE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c511010192.discost)
	e4:SetTarget(c511010192.distg)
	e4:SetOperation(c511010192.disop)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e4)
end
function c511010192.checkcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and eg:GetFirst():IsControler(tp)
end
function c511010192.checkop(e,tp,eg,ep,ev,re,r,rp)
	local val=e:GetLabelObject():GetLabel()+ev
		e:GetLabelObject():SetLabel(val)
end
function c511010192.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,e:GetLabelObject():GetLabel())
end
function c511010192.recop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Recover(p,e:GetLabelObject():GetLabel(),REASON_EFFECT)
end
function c511010192.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010192.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(aux.disfilter1,tp,0,LOCATION_ONFIELD,1,nil) end
end
function c511010192.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(aux.disfilter1,tp,0,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		if tc:IsType(TYPE_TRAPMONSTER) then
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
			e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e3)
		end
		tc=g:GetNext()
	end
end
function c511010192.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,47017574)
	Duel.CreateToken(1-tp,47017574)
end
function c511010192.indes(e,c)
return not c:IsSetCard(0x48)
end
function c511010192.reset(e,tp,eg,ep,ev,re,r,rp,chk)
	e:GetLabelObject():SetLabel(0)
end