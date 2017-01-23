--Sacrifice's Blast
--  By Shad3

local function getID()
	local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
	str=string.sub(str,1,string.len(str)-4)
	local scard=_G[str]
	local s_id=tonumber(string.sub(str,2))
	return scard,s_id
end

local scard,s_id=getID()

function scard.initial_effect(c)
	--Globals
	if not scard.gl_reg then
		scard.gl_reg=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SSET)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetCondition(scard.gtg_cd)
		ge1:SetOperation(scard.gtg_op)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_SUMMON_SUCCESS)
		ge2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge2:SetOperation(scard.sum_op)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_LEAVE_FIELD_P)
		ge3:SetOperation(scard.reflag_op)
		Duel.RegisterEffect(ge3,0)
	end
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetTarget(scard.tg)
	e1:SetOperation(scard.op)
	c:RegisterEffect(e1)
end

function scard.orcode(c)
	return c:GetOriginalCode()==s_id
end

function scard.gtg_cd(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(scard.orcode,1,nil,s_id)
end

function scard.gtg_op(e,tp,eg,ep,ev,re,r,rp)
  local g=eg:Filter(scard.orcode,nil,s_id)
	local c=g:GetFirst()
	while c do
		local p=c:GetControler()
		if Duel.GetFieldGroupCount(p,LOCATION_MZONE,LOCATION_MZONE)>0 then
			Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TARGET)
			local tc=Duel.GetFieldGroup(p,LOCATION_MZONE,LOCATION_MZONE):Select(p,1,1,nil):GetFirst()
			local fid=c:GetFieldID()
			tc:RegisterFlagEffect(s_id,RESET_EVENT+0x1000000,0,0,fid)
		end
		c=g:GetNext()
	end
end

function scard.fid_chk(c,id)
	return c:GetFieldID()==id
end

function scard.sum_op(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if bit.band(tc:GetSummonType(),SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE then
		local g=tc:GetMaterial()
		local sactg={}
		g:ForEach(function(c)
			if c:GetFlagEffect(s_id)~=0 then
				sactg[c:GetFlagEffectLabel(s_id)]=true
				c:ResetFlagEffect(s_id)
			end
		end)
		local sg=Duel.GetMatchingGroup(scard.orcode,0,LOCATION_SZONE,LOCATION_SZONE,nil)
		sg:ForEach(function(c)
			local fid=c:GetFieldID()
			if sactg[fid] then
				c:GetActivateEffect():SetLabel(tc:GetFieldID())
				local e1=Effect.CreateEffect(tc)
				e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
				e1:SetCode(s_id)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
				e1:SetRange(LOCATION_MZONE)
				e1:SetOperation(scard.des_op)
				e1:SetReset(RESET_EVENT+0x1fe0000)
				tc:RegisterEffect(e1,true)
			end
		end)
	end
end

function scard.des_op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.Destroy(c,REASON_EFFECT)~=0 then
		Duel.Damage(c:GetPreviousControler(),c:GetPreviousAttackOnField(),REASON_EFFECT)
	end
end

function scard.reflag_op(e,tp,eg,ep,ev,re,r,rp)
	local c=eg:GetFirst()
	while c do
		if c:GetFlagEffect(s_id)~=0 then
			if bit.band(c:GetReason(),REASON_RELEASE)==0 then
				c:ResetFlagEffect(s_id)
			end
		end
		c=eg:GetNext()
	end
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ac=Duel.GetAttacker()
	if chk==0 then 
		return ac:GetControler()~=tp and e:GetLabel()==ac:GetFieldID()
	end
	e:GetHandler():SetCardTarget(ac)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
	local ac=e:GetHandler():GetFirstCardTarget()
	if ac then
		Duel.RaiseSingleEvent(ac,s_id,e,REASON_EFFECT,tp,tp,e:GetHandler():GetFieldID())
	end
end