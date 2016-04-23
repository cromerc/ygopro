--Infernity Zero
function c511000145.initial_effect(c)
	c:EnableReviveLimit()
	c:SetCounterLimit(0x97,3)
	--Survival
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511000145.condition)
	e1:SetTarget(c511000145.target)
	e1:SetOperation(c511000145.operation)
	c:RegisterEffect(e1)
	--No Losing by battle LP
    local e2=Effect.CreateEffect(c)	
    e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
    e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
    e2:SetRange(LOCATION_MZONE)
    e2:SetCondition(c511000145.nlcon)
    e2:SetOperation(c511000145.nlop)
    c:RegisterEffect(e2)
    --damage reduce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CHANGE_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(1,0)
	e3:SetValue(c511000145.dlval)
	c:RegisterEffect(e3)
	--cannot destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c511000145.ncon)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--place counter
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e5:SetRange(LOCATION_MZONE)
	e5:SetCode(EVENT_DAMAGE)
	e5:SetCondition(c511000145.bcon)
	e5:SetOperation(c511000145.bop)
	c:RegisterEffect(e5)
	--self destroy
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_MZONE)
	e6:SetCode(EFFECT_SELF_DESTROY)
	e6:SetCondition(c511000145.sdcon)
	c:RegisterEffect(e6)
	--lose
	local e7=Effect.CreateEffect(c)
    e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
    e7:SetCode(EVENT_LEAVE_FIELD)
    e7:SetCondition(c511000145.losecon)
    e7:SetOperation(c511000145.lose)
    c:RegisterEffect(e7)
    --Cant deck out
    local e8=Effect.CreateEffect(c)
    e8:SetType(EFFECT_TYPE_FIELD)
    e8:SetCode(EFFECT_DRAW_COUNT)
    e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
    e8:SetRange(LOCATION_MZONE) 
    e8:SetTargetRange(1,0)
    e8:SetValue(c511000145.dc)
    c:RegisterEffect(e8)
    --damage reduce
	local e9=Effect.CreateEffect(c)
	e9:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_F)
	e9:SetCode(EVENT_CHAINING)
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e9:SetRange(LOCATION_MZONE)
	e9:SetTargetRange(1,0)
	e9:SetCondition(c511000145.damcon)
	e9:SetOperation(c511000145.damval)
	c:RegisterEffect(e9)
end
function c511000145.damcon(e,tp,eg,ep,ev,re,dam,r,rp)
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex and cp==tp then return true end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	return ex and cp==tp and Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER) and Duel.GetLP(tp)<=dam
	end
function c511000145.damval(e,tp,eg,ep,ev,re,r,rp)
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(cid)
	e1:SetValue(c511000145.damcon2)
	e1:SetReset(RESET_PHASE+PHASE_END,1)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,511000145,0,0,0)
end
function c511000145.damcon2(e,re,dam,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return dam end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cid==e:GetLabel() and Duel.GetLP(tp)<=dam then return Duel.SetLP(tp,1) 
	else return dam end
end
function c511000145.condition(e,tp,eg,ep,ev,re,r,rp)
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex and cp==tp then return true end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	return ex and cp==tp and Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER) and Duel.GetLP(tp)<=2000
end
function c511000145.target(e,tp,eg,ep,ev,re,r,rp,chk)
local c=e:GetHandler()
	if chk==0 then return Duel.GetLP(tp)<=2000
	end
end
function c511000145.operation(e,tp,eg,ep,ev,re,r,rp)
    local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
    Duel.SpecialSummon(e:GetHandler(),0,tp,tp,true,true,POS_FACEUP)
    local sg=Duel.GetFieldGroup(tp,LOCATION_HAND,0)
    Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD,e:GetHandler())
end
function c511000145.nlcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>=Duel.GetLP(tp)
end
function c511000145.nlop(e,tp,eg,ep,ev,re,r,rp)
    e:GetHandler():AddCounter(0x97,1)
    Duel.ChangeBattleDamage(ep,0)
	local lp=Duel.GetLP(tp)
	e:SetLabel(lp-1)
	Duel.PayLPCost(tp,lp-1)
	Duel.RegisterFlagEffect(tp,511000145,0,0,0)
end
function c511000145.dlval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then
	e:GetHandler():AddCounter(0x97,1)
	end
	if Duel.GetLP(e:GetHandler():GetControler())<=val then
	Duel.SetLP(e:GetHandler():GetControler(),1)
	return 0
	else
	return val end
end
function c511000145.ncon(e)
	return Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0)==0
end
function c511000145.bcon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_BATTLE)>0 and ep==tp
end
function c511000145.bop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x97,1)
end
function c511000145.sdcon(e)
	return e:GetHandler():GetCounter(0x97)==3
end
function c511000145.losecon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetLP(tp)<=1 and Duel.GetFlagEffect(tp,511000145)~=0
end
function c511000145.lose(e,tp,eg,ep,ev,re,r,rp)
    Duel.SetLP(tp,0)
end
function c511000145.dc(e)
        local tp=e:GetHandler():GetControler()
        if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 then
            return 1
        else
            return 0
        end
end
