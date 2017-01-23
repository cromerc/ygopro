--Hero Dice
function c511000487.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000487.target)
	e1:SetOperation(c511000487.activate)
	c:RegisterEffect(e1)
end
function c511000487.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x3008)
end
function c511000487.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000487.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000487.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000487.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c511000487.dfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c511000487.desfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsDestructable()
end
function c511000487.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local dice=Duel.TossDice(tp,1)
		if dice==1 then
			Duel.Damage(tp,tc:GetAttack(),REASON_EFFECT)
		elseif dice==2 and Duel.IsExistingMatchingCard(c511000487.dfilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local dg=Duel.SelectMatchingCard(tp,c511000487.dfilter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
			Duel.Destroy(dg,REASON_EFFECT)
		elseif dice==3 and Duel.IsExistingMatchingCard(c511000487.desfilter,tp,LOCATION_MZONE,0,1,e:GetHandler()) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local dg=Duel.SelectMatchingCard(tp,c511000487.desfilter,tp,LOCATION_MZONE,0,1,1,nil)
			Duel.Destroy(dg,REASON_EFFECT)
		elseif dice==4 and Duel.IsExistingMatchingCard(c511000487.desfilter,tp,0,LOCATION_MZONE,1,nil) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local dg=Duel.SelectMatchingCard(tp,c511000487.desfilter,tp,0,LOCATION_MZONE,1,1,nil)
			Duel.Destroy(dg,REASON_EFFECT)
		elseif dice==5 and Duel.IsExistingMatchingCard(c511000487.dfilter,tp,0,LOCATION_ONFIELD,1,e:GetHandler()) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			local dg=Duel.SelectMatchingCard(tp,c511000487.dfilter,tp,0,LOCATION_ONFIELD,1,1,e:GetHandler())
			Duel.Destroy(dg,REASON_EFFECT)
		elseif dice==6 then
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_DIRECT_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
		else
			return
		end
	end
end
