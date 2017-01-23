--Gulliver Chain
function c511001458.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHANGE_POS)
	e1:SetCondition(c511001458.condition)
	e1:SetTarget(c511001458.target)
	e1:SetOperation(c511001458.operation)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHANGE_POS)
	e2:SetOperation(c511001458.desop)
	e2:SetRange(LOCATION_SZONE)
	c:RegisterEffect(e2)
end
function c511001458.condition(e,tp,eg,ep,ev,re,r,rp)
	return re and rp==tp
end
function c511001458.filter(c,e,tp)
	return c:IsControler(1-tp) and c:IsCanBeEffectTarget(e) and c:IsLocation(LOCATION_MZONE)
end
function c511001458.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	local g=eg:Filter(c511001458.filter,nil,e,tp)
	if chk==0 then return g:GetCount()>0 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local tc=g:Select(tp,1,1,nil)
	Duel.SetTargetCard(tc)
	if not tc:GetFirst():IsPosition(POS_FACEUP_DEFENSE) then
		Duel.SetOperationInfo(0,CATEGORY_POSITION,tc,1,0,0)
	end
end
function c511001458.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and c:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE,POS_FACEUP_DEFENSE)
		c:SetCardTarget(tc)
	end
end
function c511001458.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetFirstCardTarget()
	if tc and tc:IsAttackPos() then
		if Duel.Destroy(tc,REASON_EFFECT)>0 then
			Duel.Destroy(c,REASON_EFFECT)
		end
	end
end
