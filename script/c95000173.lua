--Action Card - Gravity Turn
function c95000173.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95000173.target)
	e1:SetOperation(c95000173.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c95000173.handcon)
	c:RegisterEffect(e2)
end
function c95000173.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end
function c95000173.filter(c)
	return c:IsFaceup()
end
function c95000173.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c95000173.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c95000173.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c95000173.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c95000173.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
		e1:SetCode(EVENT_BATTLE_DESTROYING)
		e1:SetCondition(c95000173.atcon1)
		e1:SetOperation(c95000173.atop1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(1000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetDescription(aux.Stringid(86137485,0))
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
		e2:SetCode(EVENT_BATTLE_DESTROYING)
		e2:SetCondition(c95000173.atcon2)
		e2:SetOperation(c95000173.atop2)
		tc:RegisterEffect(e2)
	end
end
function c95000173.atcon1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return Duel.GetTurnPlayer()==tp and bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER)
		and c:IsChainAttackable() and c:IsStatus(STATUS_OPPO_BATTLE)
end
function c95000173.atop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(100)
	e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	Duel.ChainAttack()
end
function c95000173.atcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return Duel.GetTurnPlayer()~=tp and c:IsRelateToBattle() and c:IsStatus(STATUS_OPPO_BATTLE) 
		and bc:IsLocation(LOCATION_GRAVE) and bc:IsType(TYPE_MONSTER)
end
function c95000173.atop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(100)
	e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
