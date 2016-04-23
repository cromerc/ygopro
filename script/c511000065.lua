--High and Low
function c511000065.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetTarget(c511000065.target)
	e1:SetOperation(c511000065.operation)
	c:RegisterEffect(e1)
end
function c511000065.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc==Duel.GetAttackTarget() end
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if chk==0 then return d and d:IsControler(tp) and d:IsFaceup() and d:IsCanBeEffectTarget(e)
		and d:GetAttack()<a:GetAttack() end
	Duel.SetTargetCard(d)
end
function c511000065.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local ct1=Duel.DiscardDeck(tp,1,REASON_EFFECT)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()				
	if ct1==0 then return end
	if ct1>0 then
		local tcs=Duel.GetOperatedGroup():GetFirst()	
		if tcs:IsType(TYPE_MONSTER) then
			local ca=tcs:GetAttack()
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(ca)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			if tc:IsRelateToEffect(e) and a:GetAttack()<d:GetAttack() then
				Duel.BreakEffect()
				Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
				Duel.Destroy(tc,REASON_EFFECT)
			end
		end
		Duel.BreakEffect()
		if tc:IsLocation(LOCATION_ONFIELD) and Duel.SelectYesNo(tp,aux.Stringid(511000065,REASON_EFFECT)) then
			local ct2=Duel.DiscardDeck(tp,1,REASON_EFFECT)
			if ct2>0 then
				local tcs=Duel.GetOperatedGroup():GetFirst()	
				if tcs:IsType(TYPE_MONSTER) then
					local ca=tcs:GetAttack()
					local e1=Effect.CreateEffect(e:GetHandler())
					e1:SetType(EFFECT_TYPE_SINGLE)
					e1:SetCode(EFFECT_UPDATE_ATTACK)
					e1:SetValue(ca)
					e1:SetReset(RESET_EVENT+0x1fe0000)
					tc:RegisterEffect(e1)
					if tc:IsRelateToEffect(e) and a:GetAttack()<d:GetAttack() then
						Duel.BreakEffect()
						Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
						Duel.Destroy(tc,REASON_EFFECT)
					end
				end
				if tc:IsLocation(LOCATION_ONFIELD) and Duel.SelectYesNo(tp,aux.Stringid(511000065,REASON_EFFECT)) then
					local ct3=Duel.DiscardDeck(tp,1,REASON_EFFECT)
					if ct3>0 then
						local tcs=Duel.GetOperatedGroup():GetFirst()	
						if tcs:IsType(TYPE_MONSTER) then
							local ca=tcs:GetAttack()
							local e1=Effect.CreateEffect(e:GetHandler())
							e1:SetType(EFFECT_TYPE_SINGLE)
							e1:SetCode(EFFECT_UPDATE_ATTACK)
							e1:SetValue(ca)
							e1:SetReset(RESET_EVENT+0x1fe0000)
							tc:RegisterEffect(e1)
							if tc:IsRelateToEffect(e) and a:GetAttack()<d:GetAttack() then
								Duel.BreakEffect()
								Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
								Duel.Destroy(tc,REASON_EFFECT)
							end
						end
					end
				end
			end
		end
	end
end