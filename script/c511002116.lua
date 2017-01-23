--Orichalcum Chain
function c511002116.initial_effect(c)
	function aux.AddXyzProcedure(c,f,lv,ct,alterf,desc,maxct,op)
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		if f then
			mt.xyz_filter=function(mc) return mc and f(mc) end
		else
			mt.xyz_filter=function(mc) return true end
		end
		mt.minxyzct=ct
		if not maxct then
			mt.maxxyzct=ct
		else
			if maxct==5 and code~=14306092 and code~=63504681 and code~=23776077 then
				mt.maxxyzct=99
			else
				mt.maxxyzct=maxct
			end
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
		e1:SetRange(LOCATION_EXTRA)
		if not maxct then maxct=ct end
		if alterf then
			e1:SetCondition(Auxiliary.XyzCondition2(f,lv,ct,maxct,alterf,desc,op))
			e1:SetTarget(Auxiliary.XyzTarget2(f,lv,ct,maxct,alterf,desc,op))
			e1:SetOperation(Auxiliary.XyzOperation2(f,lv,ct,maxct,alterf,desc,op))
		else
			e1:SetCondition(Auxiliary.XyzCondition(f,lv,ct,maxct))
			e1:SetTarget(Auxiliary.XyzTarget(f,lv,ct,maxct))
			e1:SetOperation(Auxiliary.XyzOperation(f,lv,ct,maxct))
		end
		e1:SetValue(SUMMON_TYPE_XYZ)
		c:RegisterEffect(e1)
	end
	
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--xyz
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(511002116)
	e2:SetCondition(c511002116.con)
	e2:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e2)
	--summon
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetRange(LOCATION_SZONE)
	e4:SetOperation(c511002116.sumop)
	c:RegisterEffect(e4)
	--destroy2
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EVENT_LEAVE_FIELD)
	e5:SetCondition(c511002116.descon2)
	e5:SetOperation(c511002116.desop2)
	c:RegisterEffect(e5)
	--return
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetCode(EVENT_LEAVE_FIELD_P)
	e6:SetOperation(c511002116.checkop)
	c:RegisterEffect(e6)
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e7:SetCode(EVENT_LEAVE_FIELD)
	e7:SetOperation(c511002116.retop)
	e7:SetLabelObject(e6)
	c:RegisterEffect(e7)
	if not c511002116.global_check then
		c511002116.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511002116.xyzchk)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002116.con(e)
	return e:GetHandler():GetFlagEffect(511002115)==0
end
function c511002116.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=eg:GetFirst()
	if tc:GetSummonType()==SUMMON_TYPE_XYZ and c:GetFlagEffect(511002115)>0 and c:GetFlagEffect(511002114)==0 then
		Duel.Hint(HINT_CARD,0,511002116)
		c:SetCardTarget(tc)
		c:RegisterFlagEffect(511002114,RESET_EVENT+0x1fe0000,0,0)
	end
end
function c511002116.descon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c511002116.desop2(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c511002116.checkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsDisabled() then
		e:SetLabel(1)
	else e:SetLabel(0) end
end
function c511002116.retop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsReason(REASON_DESTROY) then return end
	if e:GetLabelObject():GetLabel()~=0 then return end
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		if not Duel.GetControl(tc,1-tp) then
			if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
				Duel.Destroy(tc,REASON_EFFECT)
			end
		end
	end
end
function c511002116.xyzchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,419)
	Duel.CreateToken(1-tp,419)
end
