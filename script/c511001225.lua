--Xyz Crown
function c511001225.initial_effect(c)
	--Synchro monster, 1 tuner + n or more monsters
	function aux.AddSynchroProcedure(c,f1,f2,ct)
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		if f1 then
			mt.tuner_filter=function(mc) return mc and f1(mc) end
		else
			mt.tuner_filter=function(mc) return true end
		end
		if f2 then
			mt.nontuner_filter=function(mc) return mc and f2(mc) end
		else
			mt.nontuner_filter=function(mc) return true end
		end
		mt.minntct=ct
		mt.maxntct=99
		mt.sync=true
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_EXTRA)
		e1:SetCondition(Auxiliary.SynCondition(f1,f2,ct,99))
		e1:SetTarget(Auxiliary.SynTarget(f1,f2,ct,99))
		e1:SetOperation(Auxiliary.SynOperation(f1,f2,ct,99))
		e1:SetValue(SUMMON_TYPE_SYNCHRO)
		c:RegisterEffect(e1)
	end
	--Synchro monster, 1 tuner + 1 monster
	function Auxiliary.AddSynchroProcedure2(c,f1,f2)
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		if f1 then
			mt.tuner_filter=function(mc) return mc and f1(mc) end
		else
			mt.tuner_filter=function(mc) return true end
		end
		if f2 then
			mt.nontuner_filter=function(mc) return mc and f2(mc) end
		else
			mt.nontuner_filter=function(mc) return true end
		end
		mt.minntct=1
		mt.maxntct=1
		mt.sync=true
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_SPSUMMON_PROC)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetRange(LOCATION_EXTRA)
		e1:SetCondition(Auxiliary.SynCondition(f1,f2,1,1))
		e1:SetTarget(Auxiliary.SynTarget(f1,f2,1,1))
		e1:SetOperation(Auxiliary.SynOperation(f1,f2,1,1))
		e1:SetValue(SUMMON_TYPE_SYNCHRO)
		c:RegisterEffect(e1)
	end
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
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511001225.target)
	e1:SetOperation(c511001225.operation)
	c:RegisterEffect(e1)
	--double xyz material
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(511001225)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c511001225.eqlimit)
	c:RegisterEffect(e3)
	--change lv
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_EQUIP)
	e5:SetCode(EFFECT_XYZ_LEVEL)
	e5:SetValue(c511001225.lv)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_SYNCHRO_LEVEL)
	c:RegisterEffect(e6)
	local e7=e5:Clone()
	e7:SetCode(EFFECT_RITUAL_LEVEL)
	c:RegisterEffect(e7)
	local e8=e5:Clone()
	e8:SetCode(EFFECT_CHANGE_LEVEL)
	c:RegisterEffect(e8)
	--double xyz material
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_EQUIP)
	e9:SetCode(511000538)
	c:RegisterEffect(e9)
	if not c511001225.global_check then
		c511001225.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511001225.xyzchk)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001225.lv(e,c,rc)
	return c:GetRank()
end
function c511001225.eqlimit(e,c)
	return c:IsType(TYPE_XYZ)
end
function c511001225.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511001225.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511001225.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001225.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511001225.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511001225.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511001225.xyzchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,419)
	Duel.CreateToken(1-tp,419)
end
