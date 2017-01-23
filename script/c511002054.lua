--No.42 スターシップ・ギャラクシー・トマホーク
function c511002054.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,7,2)
	c:EnableReviveLimit()
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetDescription(aux.Stringid(10389142,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511002054.spcost)
	e1:SetTarget(c511002054.sptg)
	e1:SetOperation(c511002054.spop)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511002054.indes)
	c:RegisterEffect(e2)
	if not c511002054.global_check then
		c511002054.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511002054.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511002054.xyz_number=42
function c511002054.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511002054.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,10389143,0,0x4011,2000,0,6,RACE_MACHINE,ATTRIBUTE_WIND) end
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ft,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ft,0,0)
end
function c511002054.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,10389143,0,0x4011,2000,0,6,RACE_MACHINE,ATTRIBUTE_WIND) then return end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	local fid=e:GetHandler():GetFieldID()
	local g=Group.CreateGroup()
	for i=1,ft do
		local token=Duel.CreateToken(tp,10389143)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetCode(EFFECT_ADD_SETCODE)
		e1:SetValue(0x48)
		e1:SetReset(RESET_EVENT+0x0fe0000)
		token:RegisterEffect(e1)
		token:RegisterFlagEffect(10389142,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		g:AddCard(token)
	end
	Duel.SpecialSummonComplete()
	g:KeepAlive()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetLabel(fid)
	e1:SetLabelObject(g)
	e1:SetCondition(c511002054.descon)
	e1:SetOperation(c511002054.desop)
	Duel.RegisterEffect(e1,tp)
end
function c511002054.desfilter(c,fid)
	return c:GetFlagEffectLabel(10389142)==fid
end
function c511002054.descon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c511002054.desfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c511002054.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c511002054.desfilter,nil,e:GetLabel())
	g:DeleteGroup()
	Duel.Destroy(tg,REASON_EFFECT)
end
function c511002054.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,10389142)
	Duel.CreateToken(1-tp,10389142)
end
function c511002054.indes(e,c)
	return not c:IsSetCard(0x48)
end
