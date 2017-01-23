--Revenge Twin Soul
function c511000905.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c511000905.condition)
	e1:SetTarget(c511000905.target)
	e1:SetOperation(c511000905.activate)
	c:RegisterEffect(e1)
end
function c511000905.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511000905.cfilter(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsAbleToRemoveAsCost()
end
function c511000905.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsPosition(POS_FACEUP_DEFENSE) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsPosition,tp,LOCATION_MZONE,0,1,nil,POS_FACEUP_DEFENSE) 
		and Duel.IsExistingMatchingCard(c511000905.cfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUPDEFENSE)
	Duel.SelectTarget(tp,Card.IsPosition,tp,LOCATION_MZONE,0,1,1,nil,POS_FACEUP_DEFENSE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511000905.cfilter,tp,LOCATION_GRAVE,0,1,2,nil)
	local tc=g:GetFirst()
	local atk=0
	while tc do
		local lvta=tc:GetLevel()*100
		atk=atk+lvta
		tc=g:GetNext()
	end
	Duel.SetTargetParam(atk)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511000905.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM))
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_DAMAGE_STEP_END)
		e2:SetCondition(c511000905.descon)
		e2:SetOperation(c511000905.desop)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
	end
end
function c511000905.descon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	return d and a:IsControler(1-tp) and a:IsRelateToBattle()
		and d:IsDefensePos() and d:IsRelateToBattle() and d:GetDefense()>a:GetAttack()
end
function c511000905.desop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	Duel.Destroy(a,REASON_EFFECT)
end
