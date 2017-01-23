--Flame Swordsman (DM)
--Scripted by edo9300
function c511000566.initial_effect(c)
	c:EnableCounterPermit(0xda,LOCATION_PZONE+LOCATION_MZONE)
	--immune to counter cleaner
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetRange(LOCATION_PZONE)
	e0:SetCode(EVENT_CHAINING)
	e0:SetOperation(c511000566.ctop)
	c:RegisterEffect(e0)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCondition(c511000566.con)
	e1:SetTarget(c511000566.target)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51100567,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTarget(c511000566.sptg)
	e2:SetOperation(c511000566.spop)
	c:RegisterEffect(e2)
	--transfer atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(51100567,6))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_PZONE)
	e3:SetCountLimit(1,511000566)
	e3:SetCondition(c511000566.con)
	e3:SetCost(c511000566.trcost)
	e3:SetTarget(c511000566.trtg)
	e3:SetOperation(c511000566.trop)
	c:RegisterEffect(e3)
	local e3a=e3:Clone()
	e3a:SetRange(LOCATION_MZONE)
	e3a:SetCost(c511000566.trcost2)
	c:RegisterEffect(e3a)
	if not c511000566.global_check then
		c511000566.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511000566.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511000566.dm=true
c511000566.dm_no_spsummon=true
c511000566.dm_custom_activate=true
function c511000566.ctpermit(e)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_SZONE) and not c:IsStatus(STATUS_DISABLED)
end
function c511000566.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c511000566.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(300)>0
end
function c511000566.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetSummonType()==SUMMON_TYPE_SPECIAL+1 then return end
	if c:GetSummonType()~=SUMMON_TYPE_SPECIAL+1 then
		c:AddCounter(0xda,18)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(ct*100)
		c:RegisterEffect(e1)
	end
end
function c511000566.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) and not e:GetHandler():IsStatus(STATUS_CHAINING) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511000566.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local ct=c:GetCounter(0xda)
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK)
		e1:SetValue(ct*100)
		c:RegisterEffect(e1)
	end
end
function c511000566.op(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	e:GetHandler():AddCounter(0xda,ct)
end
function c511000566.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if re:GetHandler():GetCode()~=38834303 then return end
	if re:GetHandler():IsCode(38834303) then
		local e0=Effect.CreateEffect(c)	
		e0:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
		e0:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e0:SetCode(EVENT_CHAIN_SOLVED)
		e0:SetRange(LOCATION_PZONE+LOCATION_MZONE)
		e0:SetOperation(c511000566.op)
		e0:SetLabel(c:GetCounter(0xda))
		e0:SetReset(RESET_CHAIN)
		c:RegisterEffect(e0)
	end
end
function c511000566.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:GetHandler():AddCounter(0xda,18)
end
function c511000566.trcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	c:RegisterFlagEffect(511000566,RESET_CHAIN,0,1)
	if chk==0 then return c:GetCounter(0xda)>=1 end
	local t={}
	local l=1
	while l<=e:GetHandler():GetCounter(0xda) do
		t[l]=l*100
		l=l+1
	end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(51100567,7))
	local announce=Duel.AnnounceNumber(tp,table.unpack(t))
	e:SetLabel(announce)
	c:RemoveCounter(tp,0xda,announce/100,REASON_COST)
end
function c511000566.trcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	c:RegisterFlagEffect(511000566,RESET_CHAIN,0,1)
	if chk==0 then return c:GetAttack()>=100 end
	local m=math.floor(c:GetAttack()/100)
	local t={}
	for i=1,m do
		t[i]=i*100
	end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(51100567,7))
	local announce=Duel.AnnounceNumber(tp,table.unpack(t))
	e:SetLabel(announce)	
	local e1=Effect.CreateEffect(c)
		e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-announce)
		c:RegisterEffect(e1)
end
function c511000566.trfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_WARRIOR)
end
function c511000566.trtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000566.trfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000566.trfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000566.trfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511000566.trop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(e:GetLabel())
	e2:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e2)
end
