--Raidraptor Retrofit Lanius
--fixed by MLD
function c511018508.initial_effect(c)
	c511018508.xyzlimit2=function(mc) return mc:IsSetCard(0xba) end
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
	
	--lvchange
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(66457407,0))
	e1:SetCategory(CATEGORY_LVCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE+LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511018508.lvtg)
	e1:SetOperation(c511018508.lvop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(511001225)
	c:RegisterEffect(e2)
	if not c511018508.global_check then
		c511018508.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511018508.xyzchk)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511018508.xyzchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,419)
	Duel.CreateToken(1-tp,419)
end
function c511018508.lvfilter(c,code,lv)
	return c:IsFaceup() and c:IsSetCard(0xba) and c:GetLevel()>0 and (c:GetCode()~=code or c:GetLevel()~=lv)
end
function c511018508.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511018508.lvfilter(chkc,c:GetCode(),c:GetLevel()) and chkc~=c end
	if chk==0 then return Duel.IsExistingTarget(c511018508.lvfilter,tp,LOCATION_MZONE,0,1,c,c:GetCode(),c:GetLevel()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511018508.lvfilter,tp,LOCATION_MZONE,0,1,1,c,c:GetCode(),c:GetLevel())
end
function c511018508.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and (c:IsFaceup() or c:IsLocation(LOCATION_HAND)) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tc:GetLevel())
		e1:SetReset(RESET_EVENT+0xfe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CHANGE_CODE)
		e2:SetReset(RESET_EVENT+0xfe0000+RESET_PHASE+PHASE_END)
		e2:SetValue(tc:GetCode())
		c:RegisterEffect(e2)
	end
end
