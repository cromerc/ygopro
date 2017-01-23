--Brave Attack
function c511000692.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_ATKCHANGE)
	e1:SetCost(c511000692.cost)
	e1:SetTarget(c511000692.tar)
	e1:SetOperation(c511000692.activate)
	c:RegisterEffect(e1)
end
function c511000692.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCurrentPhase()~=PHASE_MAIN2 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c511000692.filter(c)
	return c:IsAttackPos() and c:IsFaceup()
end
function c511000692.tar(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and c511000692.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000692.filter,tp,LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000692.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511000692.activate(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFirstTarget()
	local dg=Duel.GetMatchingGroup(c511000692.dfilter,tp,LOCATION_MZONE,0,tc)
	local val=dg:GetSum(Card.GetAttack)
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(val)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetReset(RESET_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetOperation(c511000692.desop)
		Duel.RegisterEffect(e2,tp)
		if Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)==0 then
			Duel.Damage(1-tp,tc:GetAttack(),REASON_BATTLE)
		else
			local g=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_MZONE,1,1,nil)
			local tg=g:GetFirst()
			Duel.CalculateDamage(tc,tg)
		end
	end
end
function c511000692.dfilter(c)
	return c:IsAttackPos() and c:IsFaceup() and c:IsDestructable()
end
function c511000692.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511000692.dfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
