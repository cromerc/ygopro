--CNo.103 神葬零嬢ラグナ・インフィニティ
function c511001430.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,5,3)
	c:EnableReviveLimit()
	--Rank Up Check
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c511001430.rankupregop)
	c:RegisterEffect(e1)
	--activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(511001430)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511001430.damcost)
	e2:SetCondition(c511001430.damcon)
	e2:SetTarget(c511001430.damtg)
	e2:SetOperation(c511001430.damop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001430,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetCondition(c511001430.spcon)
	e3:SetTarget(c511001430.sptg)
	e3:SetOperation(c511001430.spop)
	e3:SetLabelObject(e1)
	c:RegisterEffect(e3)
	--battle indestructable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(c511001430.indes)
	c:RegisterEffect(e4)
	if not c511001430.global_check then
		c511001430.global_check=true
		--register
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(c511001430.operation)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511001430.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511001430.xyz_number=103

function c511001430.rumfilter(c)
	return c:IsCode(94380860) and not c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c511001430.rankupregop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and (rc:IsSetCard(0x95) or rc:IsCode(100000581) or rc:IsCode(111011002) or rc:IsCode(511000580) or rc:IsCode(511002068) or rc:IsCode(511002164) or rc:IsCode(93238626)) and e:GetHandler():GetMaterial():IsExists(c511001430.rumfilter,1,nil) then
		e:SetLabel(1)
	else
		e:SetLabel(0)
	end
end
function c511001430.damcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	e:SetLabel(ev)
	return eg:GetCount()==1 and ec:IsControler(1-tp) and ev>0
end
function c511001430.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511001430.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c511001430.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511001430.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_EFFECT) and c:IsPreviousLocation(LOCATION_MZONE) 
end
function c511001430.spfilter(c,e,tp)
	return c:IsCode(94380860) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001430.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511001430.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp) and e:GetLabelObject():GetLabel()==1 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511001430.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001430.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511001430.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(nil,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:IsFaceup() and tc:GetFlagEffect(511001430)==0 then
			local e1=Effect.CreateEffect(c)	
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_CHAIN_SOLVED)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(tc:GetAttack())
			e1:SetOperation(c511001430.op)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511001430,RESET_EVENT+0x1fe0000,0,1) 	
		end	
		tc=g:GetNext()
	end
end
function c511001430.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==c:GetAttack() then return end
	local val=0
	if e:GetLabel()>c:GetAttack() then
		val=e:GetLabel()-c:GetAttack()
	else
		val=c:GetAttack()-e:GetLabel()
	end
	Duel.RaiseEvent(c,511001430,e,0,0,tp,val)
	e:SetLabel(c:GetAttack())
end
function c511001430.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,20785975)
	Duel.CreateToken(1-tp,20785975)
end
function c511001430.indes(e,c)
	return not c:IsSetCard(0x48)
end