--クリボー
function c511002854.initial_effect(c)
	--no damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40640057,0))
	e1:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511002854.con1)
	e1:SetCost(c511002854.cost)
	e1:SetOperation(c511002854.op1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511002854.con2)
	e2:SetCost(c511002854.cost)
	e2:SetOperation(c511002854.op2)
	c:RegisterEffect(e2)
	--target
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(84565800,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetTarget(c511002854.negtg)
	e3:SetOperation(c511002854.negop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(20374351,1))
	e4:SetCategory(CATEGORY_DISABLE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_CHAINING)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c511002854.discon)
	e4:SetTarget(c511002854.distg)
	e4:SetOperation(c511002854.disop)
	c:RegisterEffect(e4)
end
function c511002854.con1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>0
end
function c511002854.con2(e,tp,eg,ep,ev,re,r,rp)
	return aux.damcon1(e,tp,eg,ep,ev,re,r,rp) and re:IsActiveType(TYPE_MONSTER)
end
function c511002854.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c511002854.op1(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511002854.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c511002854.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
function c511002854.op2(e,tp,eg,ep,ev,re,r,rp,val,r,rc)
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(cid)
	e1:SetValue(c511002854.refcon)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
end
function c511002854.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cid==e:GetLabel() then e:SetLabel(val) return 0
	else return val end
end
function c511002854.negtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,e:GetHandler():GetAttack())
end
function c511002854.negop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.NegateAttack()
	if c:IsRelateToEffect(e) then
		Duel.BreakEffect()
		if Duel.Destroy(c,REASON_EFFECT)>0 then
			Duel.Damage(tp,c:GetAttack(),REASON_EFFECT)
		end
	end
end
function c511002854.discon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsStatus(STATUS_BATTLE_DESTROYED) then return false end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	return tg and tg:IsContains(c) and Duel.IsChainDisablable(ev)
end
function c511002854.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,e:GetHandler():GetAttack())
end
function c511002854.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	if c:IsRelateToEffect(e) then
		Duel.BreakEffect()
		if Duel.Destroy(c,REASON_EFFECT)>0 then
			Duel.Damage(tp,c:GetAttack(),REASON_EFFECT)
		end
	end
end
