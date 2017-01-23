--Divergence
function c511000051.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_BATTLE_START)
	e1:SetTarget(c511000051.atktg1)
	e1:SetOperation(c511000051.atkop)
	c:RegisterEffect(e1)
	--change target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000051,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511000051.condition)
	e2:SetTarget(c511000051.atktg2)
	e2:SetOperation(c511000051.atkop)
	c:RegisterEffect(e2)
end
function c511000051.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:IsControler(tp) and tc:IsFaceup() and tc:IsRace(RACE_MACHINE)
end
function c511000051.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE)
end
function c511000051.atktg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000051.filter(chkc) end
	if chk==0 then return true end
	e:SetProperty(0)
	if Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and tp~=Duel.GetTurnPlayer() then
		local at=Duel.GetAttackTarget()
		if at and Duel.IsExistingTarget(c511000051.filter,tp,LOCATION_MZONE,0,1,at) and Duel.SelectYesNo(tp,aux.Stringid(511000051,1)) then
			e:SetProperty(EFFECT_FLAG_CARD_TARGET)
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
			Duel.SelectTarget(tp,c511000051.filter,tp,LOCATION_MZONE,0,1,1,at)
		end
	end
end
function c511000051.atktg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000051.filter(chkc) end
	local at=Duel.GetAttackTarget()
	if chk==0 then return Duel.IsExistingTarget(c511000051.filter,tp,LOCATION_MZONE,0,1,at) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511000051.filter,tp,LOCATION_MZONE,0,1,1,at)
end
function c511000051.atkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.ChangeAttackTarget(tc)
	end
end
