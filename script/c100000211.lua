--デステニー・ストリングス
function c100000211.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c100000211.target)
	e1:SetOperation(c100000211.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c100000211.eqlimit)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)	
	e3:SetRange(LOCATION_SZONE)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetCost(c100000211.atcost)
	e3:SetCondition(c100000211.atcon)
	e3:SetTarget(c100000211.attg)
	e3:SetOperation(c100000211.atop)
	c:RegisterEffect(e3)
end
function c100000211.eqlimit(e,c)
	return c:IsSetCard(0x83)
end
function c100000211.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x83)
end
function c100000211.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c100000211.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000211.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c100000211.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c100000211.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c100000211.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeckAsCost(tp,1) end
	Duel.DiscardDeck(tp,1,REASON_COST)
	local tc=Duel.GetOperatedGroup():GetFirst()
	if tc:IsType(TYPE_MONSTER) then
		e:SetLabel(tc:GetLevel()-1)
	else
		e:SetLabel(0)
	end
end
function c100000211.atcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler():GetEquipTarget()
end
function c100000211.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetEquipTarget() end
	Duel.SetTargetCard(e:GetHandler():GetEquipTarget())
end
function c100000211.atop(e,tp,eg,ep,ev,re,r,rp)
	local lv=e:GetLabel()
	local c=e:GetHandler()
	local tc=c:GetEquipTarget()
	if tc and c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() and lv>0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		--battle
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetRange(LOCATION_SZONE)
		e2:SetCode(EVENT_DAMAGE_CALCULATING)
		e2:SetCondition(c100000211.indescon)
		e2:SetOperation(c100000211.indesop)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2)
	else
		if Duel.NegateAttack() then
			Duel.SkipPhase(Duel.GetTurnPlayer(),PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
		end
	end	
end
function c100000211.indescon(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetEquipTarget():GetBattleTarget()
	return bc and bc:IsAttackPos()
end
function c100000211.indesop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetEquipTarget():GetBattleTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	bc:RegisterEffect(e1,true)
end
