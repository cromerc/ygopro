--Zombie Heart
--scripted by:urielkama
function c511004100.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511004100.target)
	e1:SetOperation(c511004100.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c511004100.eqlimit)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511004100.con)
	e3:SetTarget(c511004100.tg)
	e3:SetOperation(c511004100.op)
	c:RegisterEffect(e3)
	--negate
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511004100,0))
	e3:SetCategory(CATEGORY_NEGATE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCondition(c511004100.condition2)
	e3:SetTarget(c511004100.target2)
	e3:SetOperation(c511004100.operation2)
	c:RegisterEffect(e3)
	if not c511004100.global_check then
		c511004100.global_check=true
		c511004100[0]=false
		c511004100[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DAMAGE_STEP_END)
		ge1:SetOperation(c511004100.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c511004100.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511004100.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE)
end
function c511004100.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511004100.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511004100.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c511004100.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511004100.operation(e,tp,eg,ep,ev,re,r,rp)
local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511004100.eqlimit(e,c)
	return c:IsRace(RACE_ZOMBIE)
end
function c511004100.checkop(e,tp,eg,ep,ev,re,r,rp)
local eqc=e:GetHandler():GetEquipTarget()
local a=Duel.GetAttacker()
local d=Duel.GetAttackTarget()
if not d or (a~=eqc and d~=eqc) then return end
local la=a:GetAttack()
local ld=d:GetAttack()
	if (a==eqc and ld>=la) or (d==eqc and la>=ld) then
		c511004100[0]=true
		c511004100[1]=true
	end
end
function c511004100.clear(e,tp,eg,ep,ev,re,r,rp)
	c511004100[0]=false
	c511004100[1]=false
end
function c511004100.eqfilter(c,ec,tp)
	return c:IsOnField() and c:IsControler(tp) and c:GetEquipTarget()==ec
end
function c511004100.condition2(e,tp,eg,ep,ev,re,r,rp)
	if e==re or e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) or not Duel.IsChainNegatable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	return ex and tg~=nil and tc+tg:FilterCount(c511004100.eqfilter,nil)-tg:GetCount()==1 and Duel.IsChainNegatable(ev)
end
function c511004100.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function c511004100.operation2(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	e:GetHandler():RegisterFlagEffect(511004100,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,0)
end
function c511004100.con(e,tp,eg,ep,ev,re,r,rp)
	return c511004100[tp] or e:GetHandler():GetFlagEffect(511004100)>0
end
function c511004100.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local atk=e:GetHandler():GetEquipTarget():GetAttack()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c511004100.op(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end