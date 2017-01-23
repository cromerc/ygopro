--Defend Slime
function c511000248.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetDescription(aux.Stringid(511000248,0))
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetTarget(c511000248.atktg1)
	e1:SetOperation(c511000248.atkop)
	c:RegisterEffect(e1)
	--Activate Damage Protection
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000248,1))
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_CHAINING)
	e2:SetCondition(c511000248.dmgcon)
	e2:SetCost(c511000248.dmgcost)
	e2:SetOperation(c511000248.dmgop)
	c:RegisterEffect(e2)
	--Activate Battle Damage Protection
   	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetDescription(aux.Stringid(511000248,2))
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_BATTLE_CONFIRM)
	e3:SetCondition(c511000248.battledmgcon)
	e3:SetCost(c511000248.battledmgcost)
	e3:SetOperation(c511000248.battledmgop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000248,2))
	e4:SetType(EFFECT_TYPE_ACTIVATE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c511000248.battledmgcon2)
	e4:SetCost(c511000248.battledmgcost)
	e4:SetOperation(c511000248.battledmgop)
	c:RegisterEffect(e4)
	--Slime's Defense
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511000248,0))
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_BE_BATTLE_TARGET)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c511000248.atkcon)
	e5:SetTarget(c511000248.atktg2)
	e5:SetOperation(c511000248.atkop)
	c:RegisterEffect(e5)
	--Slime's Damage Protection
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(511000248,1))
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetCode(EVENT_CHAINING)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCondition(c511000248.dmgcon)
	e6:SetCost(c511000248.dmgcost)
	e6:SetOperation(c511000248.dmgop)
	c:RegisterEffect(e6)
	--Slime's Battle Damage Protection
   	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(511000248,2))
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CARD_TARGET)
	e7:SetCode(EVENT_BATTLE_CONFIRM)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCondition(c511000248.battledmgcon)
	e7:SetCost(c511000248.battledmgcost)
	e7:SetOperation(c511000248.battledmgop)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(511000248,2))
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CARD_TARGET)
	e8:SetCode(EVENT_ATTACK_ANNOUNCE)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCondition(c511000248.battledmgcon2)
	e8:SetCost(c511000248.battledmgcost)
	e8:SetOperation(c511000248.battledmgop)
	c:RegisterEffect(e8)
end
function c511000248.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.GetAttackTarget()~=nil
end
function c511000248.filter(c)
	return c:IsFaceup() and c:IsCode(31709826)
end
function c511000248.atktg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000248.filter(chkc) end
	if chk==0 then return true end
	e:SetProperty(0)
	if Duel.CheckEvent(EVENT_BE_BATTLE_TARGET) and tp~=Duel.GetTurnPlayer() then
		local at=Duel.GetAttackTarget()
		if at and Duel.IsExistingTarget(c511000248.filter,tp,LOCATION_MZONE,0,1,at) and Duel.SelectYesNo(tp,aux.Stringid(511000248,0)) then
			e:SetProperty(EFFECT_FLAG_CARD_TARGET)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
			Duel.SelectTarget(tp,c511000248.filter,tp,LOCATION_MZONE,0,1,1,at)
		end
	end
end
function c511000248.atktg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000248.filter(chkc) end
	local at=Duel.GetAttackTarget()
	if chk==0 then return Duel.IsExistingTarget(c511000248.filter,tp,LOCATION_MZONE,0,1,at) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511000248.filter,tp,LOCATION_MZONE,0,1,1,at)
end
function c511000248.atkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.ChangeAttackTarget(tc)
	end
end
function c511000248.dmgcon(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_SPELL+TYPE_TRAP) and not re:IsHasType(EFFECT_TYPE_ACTIVATE) then return false end
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex and (cp==tp or cp==PLAYER_ALL) then return true end
	return ex and tg~=nil and tc+tg:FilterCount(Card.IsOnField,nil)-tg:GetCount()>0
end
function c511000248.dmgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511000248.filter,1,nil) end
end
function c511000248.dmgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectReleaseGroup(tp,c511000248.filter,1,1,nil)
	Duel.Destroy(g,REASON_COST)
	Duel.NegateActivation(ev)
	if re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
function c511000248.battledmgcon(e,tp,eg,ep,ev,re,r,rp,chk)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if not d then return false end
	return (a:GetControler()==tp and a:GetAttack()<d:GetAttack() and d:IsAttackPos() or a:GetControler()==tp and a:GetAttack()<d:GetDefense() 
		and d:IsDefensePos() or d:GetControler()==tp and d:GetAttack()<a:GetAttack())
end
function c511000248.battledmgcon2(e,tp,eg,ep,ev,re,r,rp,chk)
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c511000248.battledmgcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if tp==Duel.GetTurnPlayer() and chk==0 then return Duel.CheckReleaseGroup(tp,c511000248.filter,1,Duel.GetAttacker()) and Duel.GetFlagEffect(tp,511000248)==0 end
	if tp~=Duel.GetTurnPlayer() and chk==0 then return Duel.CheckReleaseGroup(tp,c511000248.filter,1,Duel.GetAttackTarget()) and Duel.GetFlagEffect(tp,511000248)==0 end
	Duel.RegisterFlagEffect(tp,511000248,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c511000248.battledmgop(e,tp,eg,ep,ev,re,r,rp)
	if tp==Duel.GetTurnPlayer() then
	local g=Duel.SelectReleaseGroup(tp,c511000248.filter,1,1,Duel.GetAttacker())
	Duel.Destroy(g,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	Duel.RegisterEffect(e1,tp)
	end
	if tp~=Duel.GetTurnPlayer() then
	local g=Duel.SelectReleaseGroup(tp,c511000248.filter,1,1,Duel.GetAttackTarget())
	Duel.Destroy(g,REASON_COST)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	Duel.RegisterEffect(e1,tp)
end
end
