--Action Field - Morphtronic Map
function c95000164.initial_effect(c)
	--Activate	
	local e1=Effect.CreateEffect(c)	
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetOperation(c95000164.op)
	c:RegisterEffect(e1)
	--redirect
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetOperation(c95000164.repop)
	c:RegisterEffect(e2)		
	--unaffectable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_IMMUNE_EFFECT)
	e6:SetValue(c95000164.ctcon2)
	c:RegisterEffect(e6)
	--cannot set
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_CANNOT_SSET)
	e7:SetRange(LOCATION_SZONE)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e7:SetTargetRange(1,0)
	e7:SetTarget(c95000166.sfilter)
	c:RegisterEffect(e7)
	-- Add Action Card
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(95000164,0))
	e8:SetType(EFFECT_TYPE_QUICK_O)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCode(EVENT_FREE_CHAIN)
	e8:SetCondition(c95000164.condition)
	e8:SetTarget(c95000164.Acttarget)
	e8:SetOperation(c95000164.operation)
	c:RegisterEffect(e8)
	--add counter
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e9:SetCode(EVENT_CHANGE_POS)
	e9:SetRange(LOCATION_SZONE)
	e9:SetCondition(c95000164.accon)
	e9:SetOperation(c95000164.acop)
	c:RegisterEffect(e9)
	--atkup
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_UPDATE_ATTACK)
	e10:SetRange(LOCATION_SZONE)
	e10:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e10:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x26))
	e10:SetValue(c95000164.atkval)
	c:RegisterEffect(e10)
	--special summon
	local e11=Effect.CreateEffect(c)
	e11:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e11:SetDescription(aux.Stringid(56074358,0))
	e11:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e11:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e11:SetCode(EVENT_TO_GRAVE)
	e11:SetCondition(c95000164.spcon)
	e11:SetTarget(c95000164.sptg)
	e11:SetOperation(c95000164.spop)
	c:RegisterEffect(e11)
	--
	local eb=Effect.CreateEffect(c)
	eb:SetType(EFFECT_TYPE_FIELD)
	eb:SetCode(EFFECT_CANNOT_TO_DECK)
	eb:SetRange(LOCATION_SZONE)
	eb:SetTargetRange(LOCATION_SZONE,0)
	eb:SetTarget(c95000164.tgn)
	c:RegisterEffect(eb)
	local ec=eb:Clone()
	ec:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(ec)
	local ed=eb:Clone()
	ed:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(ed)
	local ee=eb:Clone()
	ee:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(ee)
	
	
end
function c95000164.ctcon2(e,re)
	return re:GetHandler()~=e:GetHandler()
end
--speed Duel Filter
function c95000164.SDfilter(c)
	return c:GetCode()==511004001
end
--vanilla mode filter
function c95000164.Vfilter(c)
	return c:GetCode()==511004002
end
function c95000164.op(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	local tc2=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)	
	
	--check if number of card >20 if speed duel or >40 if other duel
	if Duel.IsExistingMatchingCard(c95000164.SDfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil) and Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetCount()<20 then
	Duel.Win(1-tp,0x55)
	end
	if Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,e:GetHandler()):GetCount()<40 and not Duel.IsExistingMatchingCard(c95000164.SDfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil) then
	Duel.Win(1-tp,0x55)
	end
	
	--move to field
	if tc==nil then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		if tc2==nil then
			local token=Duel.CreateToken(tp,95000164,nil,nil,nil,nil,nil,nil)		
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fc0000)
			e1:SetValue(TYPE_SPELL+TYPE_FIELD)
			token:RegisterEffect(e1)
			Duel.MoveToField(token,tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
			Duel.SpecialSummonComplete()
		end
		-- add ability Yell when Vanilla mode activated
		-- if Duel.IsExistingMatchingCard(c95000164.Vfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil) then
			-- c95000164.tableAction.push(95000200)
		-- end
	else
		Duel.SendtoDeck(e:GetHandler(),nil,-2,REASON_EFFECT)
	end
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end

function c95000166.sfilter(e,c,tp)
	return c:IsType(TYPE_FIELD) 
end
function c95000164.tgn(e,c)
	return c==e:GetHandler()
end


-- Add Action Card
function c95000164.Acttarget(e,tp,eg,ep,ev,re,r,rp,chk)
if chk==0 then return true end
Duel.Hint(HINT_SELECTMSG,tp,564)
local seed=0
if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then
local g=Duel.GetMatchingGroup(nil,tp,LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_HAND+LOCATION_SZONE,0,nil)
seed = g:GetFirst():GetCode()
else
local g=Duel.GetDecktopGroup(tp,1)
local tc=g:GetFirst()
seed=tc:GetCode()
end

math.randomseed( seed )

ac=math.random(1,#tableAction)
e:SetLabel(tableAction[ac])
end
function c95000164.operation(e,tp,eg,ep,ev,re,r,rp)
local dc=Duel.TossDice(tp,1)
if dc==2 or dc==4 or dc==6 then

Duel.RegisterFlagEffect(tp,95000164,RESET_PHASE+PHASE_END,0,1)
end
if dc==1 or dc==2 then
if not Duel.IsExistingMatchingCard(c95000164.cfilter,tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil) then	
		  local token=Duel.CreateToken(tp,e:GetLabel())
		Duel.SendtoHand(token,nil,REASON_EFFECT)
end
end

if dc==5 or dc==6 then
 if not Duel.IsExistingMatchingCard(c95000164.cfilter,1-tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil) then
		  local token=Duel.CreateToken(1-tp,e:GetLabel())
		Duel.SendtoHand(token,nil,REASON_EFFECT)
		end

end

end
function c95000164.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c95000164.cfilter,tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil)
	and Duel.GetFlagEffect(e:GetHandlerPlayer(),95000164)==0
	and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c95000164.cfilter(c)
	return c:IsSetCard(0xac1)
end
tableAction = {
95000044,
95000045,
95000046,
95000143
} 
tableAction = {
95000044,
95000045,
95000046,
95000143
} 
function c95000164.repop(e)
	local c=e:GetHandler()
		if c:GetFlagEffect(900000007)==0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAIN_END)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetLabelObject(c)
		e1:SetOperation(c95000164.returnop)
		Duel.RegisterEffect(e1,0)
		c:RegisterFlagEffect(900000007,0,0,1)
	end
	Duel.SendtoDeck(c,nil,-2,REASON_RULE)
end
function c95000164.returnop(e)
	local c=e:GetLabelObject()
	local tp=c:GetControler()
	local fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if not fc then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
	if fc and fc:GetFlagEffect(195000164)==0 then
	--action card get
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95000164,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c95000164.condition)
	e1:SetTarget(c95000164.Acttarget)
	e1:SetOperation(c95000164.operation)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	fc:RegisterEffect(e1)
	--cannot set
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_CANNOT_SSET)
	e4:SetRange(LOCATION_SZONE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetTargetRange(1,0)
	e4:SetReset(RESET_EVENT+0x1fe0000)
	e4:SetTarget(c95000166.sfilter)
	fc:RegisterEffect(e4)
	fc:RegisterFlagEffect(195000164,RESET_EVENT+0x1fe0000,0,1)
	end
end

function c95000164.atkval(e,c)
	return e:GetHandler():GetCounter(0x8)*150
end
function c95000164.cfilter(c)
	local np=c:GetPosition()
	local pp=c:GetPreviousPosition()
	return not c:IsStatus(STATUS_CONTINUOUS_POS) and ((np<3 and pp>3) or (pp<3 and np>3))
end
function c95000164.accon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c95000164.cfilter,1,nil)
end
function c95000164.acop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x8,1)
end
function c95000164.spcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and bit.band(c:GetPreviousLocation(),LOCATION_ONFIELD)~=0
end
function c95000164.filter(c,e,tp)
	return c:IsSetCard(0x26) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c95000164.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c95000164.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c95000164.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c95000164.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c95000164.spop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end

