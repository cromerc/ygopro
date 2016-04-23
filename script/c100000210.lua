--アタック・ギミック
function c100000210.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000210.target)
	e1:SetOperation(c100000210.activate)
	c:RegisterEffect(e1)
end
function c100000210.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x83)
end
function c100000210.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000210.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000210.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c100000210.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c100000210.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(500)
		tc:RegisterEffect(e1)		
		--damage
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetDescription(aux.Stringid(100000210,0))
		e2:SetCategory(CATEGORY_DAMAGE)
		e2:SetCode(EVENT_BATTLE_DESTROYING)
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetCondition(c100000210.condition)
		e2:SetTarget(c100000210.target2)		
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetOperation(c100000210.operation)
		tc:RegisterEffect(e2)
	end
end
function c100000210.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local d=Duel.GetAttackTarget()
	if d==c then d=Duel.GetAttacker() end
	e:SetLabel(d:GetAttack())
	return true
end
function c100000210.target2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c100000210.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
