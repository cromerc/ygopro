--Action Field - Savage Colosseum
function c95000166.initial_effect(c)
	--Activate	
	local e1=Effect.CreateEffect(c)	
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetOperation(c95000166.op)
	c:RegisterEffect(e1)
	--redirect
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetOperation(c95000166.repop)
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
	e6:SetValue(c95000166.ctcon2)
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
	e8:SetDescription(aux.Stringid(95000166,0))
	e8:SetType(EFFECT_TYPE_QUICK_O)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCode(EVENT_FREE_CHAIN)
	e8:SetCondition(c95000166.condition)
	e8:SetTarget(c95000166.Acttarget)
	e8:SetOperation(c95000166.operation)
	c:RegisterEffect(e8)
	--to defence
	local e9=Effect.CreateEffect(c)
	e9:SetDescription(aux.Stringid(32391631,0))
	e9:SetCategory(CATEGORY_RECOVER)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e9:SetCode(EVENT_DAMAGE_STEP_END)
	e9:SetRange(LOCATION_SZONE)
	e9:SetTarget(c95000166.rectg)
	e9:SetCondition(c95000166.IRLcondition)
	e9:SetOperation(c95000166.recop)
	c:RegisterEffect(e9)
	--must attack
	local e10=Effect.CreateEffect(c)
	e10:SetType(EFFECT_TYPE_FIELD)
	e10:SetCode(EFFECT_MUST_ATTACK)
	e10:SetRange(LOCATION_SZONE)
	e10:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	c:RegisterEffect(e10)
	local e11=Effect.CreateEffect(c)
	e11:SetType(EFFECT_TYPE_FIELD)
	e11:SetCode(EFFECT_CANNOT_EP)
	e11:SetRange(LOCATION_SZONE)
	e11:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e11:SetTargetRange(1,1)
	e11:SetCondition(c95000166.becon)
	c:RegisterEffect(e11)
	--destroy
	local e12=Effect.CreateEffect(c)
	e12:SetDescription(aux.Stringid(32391631,1))
	e12:SetCategory(CATEGORY_DESTROY)
	e12:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e12:SetRange(LOCATION_SZONE)
	e12:SetCountLimit(1)
	e12:SetCode(EVENT_PHASE+PHASE_END)
	e12:SetTarget(c95000166.destg)
	e12:SetCondition(c95000166.IRLcondition)
	e12:SetOperation(c95000166.desop)
	c:RegisterEffect(e12)
	--
	local eb=Effect.CreateEffect(c)
	eb:SetType(EFFECT_TYPE_FIELD)
	eb:SetCode(EFFECT_CANNOT_TO_DECK)
	eb:SetRange(LOCATION_SZONE)
	eb:SetTargetRange(LOCATION_SZONE,0)
	eb:SetTarget(c95000166.tgn)
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
	
	
	if not c95000166.global_check then
		c95000166.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ATTACK_ANNOUNCE)
		ge1:SetOperation(c95000166.check)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ATTACK_DISABLED)
		ge2:SetOperation(c95000166.check2)
		Duel.RegisterEffect(ge2,0)
	end
end
function c95000166.ctcon2(e,re)
	return re:GetHandler()~=e:GetHandler()
end
--speed Duel Filter
function c95000166.SDfilter(c)
	return c:GetCode()==511004001
end
--vanilla mode filter
function c95000166.Vfilter(c)
	return c:GetCode()==511004002
end
function c95000166.op(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	local tc2=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)	
	
	--check if number of card >20 if speed duel or >40 if other duel
	if Duel.IsExistingMatchingCard(c95000166.SDfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil) and Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,nil):GetCount()<20 then
	Duel.Win(1-tp,0x55)
	end
	if Duel.GetMatchingGroup(nil,tp,LOCATION_HAND+LOCATION_DECK,0,e:GetHandler()):GetCount()<40 and not Duel.IsExistingMatchingCard(c95000166.SDfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil) then
	Duel.Win(1-tp,0x55)
	end
	
	--move to field
	if tc==nil then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		if tc2==nil then
			local token=Duel.CreateToken(tp,95000166,nil,nil,nil,nil,nil,nil)		
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
		-- if Duel.IsExistingMatchingCard(c95000166.Vfilter,tp,LOCATION_DECK+LOCATION_HAND+LOCATION_REMOVED,0,1,nil) then
			-- c95000166.tableAction.push(95000200)
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
function c95000166.tgn(e,c)
	return c==e:GetHandler()
end


-- Add Action Card
function c95000166.Acttarget(e,tp,eg,ep,ev,re,r,rp,chk)
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
function c95000166.operation(e,tp,eg,ep,ev,re,r,rp)
local dc=Duel.TossDice(tp,1)
if dc==2 or dc==4 or dc==6 then

Duel.RegisterFlagEffect(tp,95000166,RESET_PHASE+PHASE_END,0,1)
end
if dc==1 or dc==2 then
if not Duel.IsExistingMatchingCard(c95000166.cfilter,tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil) then	
		  local token=Duel.CreateToken(tp,e:GetLabel())
		Duel.SendtoHand(token,nil,REASON_EFFECT)
end
end

if dc==5 or dc==6 then
 if not Duel.IsExistingMatchingCard(c95000166.cfilter,1-tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil) then
		  local token=Duel.CreateToken(1-tp,e:GetLabel())
		Duel.SendtoHand(token,nil,REASON_EFFECT)
		end

end

end
function c95000166.condition(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c95000166.cfilter,tp,LOCATION_SZONE+LOCATION_HAND,0,1,nil)
	and Duel.GetFlagEffect(e:GetHandlerPlayer(),95000166)==0
	and not e:GetHandler():IsStatus(STATUS_CHAINING)
end
function c95000166.cfilter(c)
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
function c95000166.repop(e)
	local c=e:GetHandler()
		if c:GetFlagEffect(900000007)==0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAIN_END)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetLabelObject(c)
		e1:SetOperation(c95000166.returnop)
		Duel.RegisterEffect(e1,0)
		c:RegisterFlagEffect(900000007,0,0,1)
	end
	Duel.SendtoDeck(c,nil,-2,REASON_RULE)
end
function c95000166.returnop(e)
	local c=e:GetLabelObject()
	local tp=c:GetControler()
	local fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if not fc then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	end
	if fc and fc:GetFlagEffect(195000166)==0 then
	--action card get
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95000166,0))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCondition(c95000166.condition)
	e1:SetTarget(c95000166.Acttarget)
	e1:SetOperation(c95000166.operation)
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
	fc:RegisterFlagEffect(195000166,RESET_EVENT+0x1fe0000,0,1)
	end
end

function c95000166.IRLcondition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c95000166.check(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local ct=tc:GetFlagEffectLabel(32391631)
	if ct then
		tc:SetFlagEffectLabel(32391631,ct+1)
	else
		tc:RegisterFlagEffect(32391631,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,1)
	end
end
function c95000166.check2(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local ct=tc:GetFlagEffectLabel(32391631)
	if ct then
		tc:SetFlagEffectLabel(32391631,ct-1)
	end
end
function c95000166.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(Duel.GetTurnPlayer())
	Duel.SetTargetParam(300)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,Duel.GetTurnPlayer(),300)
end
function c95000166.recop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or not Duel.GetAttacker():IsRelateToBattle() then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
function c95000166.becon(e)
	return Duel.GetTurnPlayer()==tp and Duel.IsExistingMatchingCard(Card.IsAttackable,Duel.GetTurnPlayer(),LOCATION_MZONE,0,1,nil)
end
function c95000166.desfilter(c)
	local ct=c:GetFlagEffectLabel(32391631)
	return c:IsPosition(POS_FACEUP_ATTACK) and (not ct or ct==0) and c:IsDestructable()
end
function c95000166.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c95000166.desfilter,Duel.GetTurnPlayer(),LOCATION_MZONE,0,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c95000166.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c95000166.desfilter,Duel.GetTurnPlayer(),LOCATION_MZONE,0,e:GetHandler())
	Duel.Destroy(g,REASON_EFFECT)
end
