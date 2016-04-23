--ディフェンス・メイデン
function c100000136.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetTarget(c100000136.atktg1)
	e1:SetOperation(c100000136.atkop)
	c:RegisterEffect(e1)
	--change target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000136,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000136.atkcon)
	e2:SetTarget(c100000136.atktg2)
	e2:SetOperation(c100000136.atkop)
	c:RegisterEffect(e2)
end
function c100000136.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return tp~=Duel.GetTurnPlayer() and at and (at:IsFacedown() or not at:IsCode(100000139))
end
function c100000136.filter(c)
	return c:IsFaceup() and c:IsCode(100000139)
end
function c100000136.atktg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000136.filter(chkc) end
	if chk==0 then return true end
	e:SetProperty(0)
	if Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and tp~=Duel.GetTurnPlayer() then
		local at=Duel.GetAttackTarget()
		if at and (at:IsFacedown() or not at:IsCode(100000139)) and Duel.IsExistingTarget(c100000136.filter,tp,LOCATION_MZONE,0,1,nil) then
			e:SetProperty(EFFECT_FLAG_CARD_TARGET)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
			Duel.SelectTarget(tp,c100000136.filter,tp,LOCATION_MZONE,0,1,1,nil)
		end
	end
end
function c100000136.atktg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000136.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000136.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c100000136.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c100000136.atkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.ChangeAttackTarget(tc)
	end
end