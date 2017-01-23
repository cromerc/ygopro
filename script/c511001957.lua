--閃珖竜 スターダスト
function c511001957.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511001957.reptg)
	e1:SetValue(c511001957.repval)
	c:RegisterEffect(e1)
end
function c511001957.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetFlagEffect(511001957)==0 and eg:GetCount()>0 end
	if Duel.SelectYesNo(tp,aux.Stringid(61965407,0)) then
		c:RegisterFlagEffect(511001957,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			Duel.Hint(HINT_CARD,0,511001957)
			Duel.HintSelection(g)
			if eg:IsContains(tc) then
				e:SetLabelObject(tc)
			else
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_SET_AVAILABLE)
				e1:SetCountLimit(1)
				e1:SetValue(c511001957.valcon)
				e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
				tc:RegisterEffect(e1)
				e:SetLabelObject(nil)
			end
		end
	end
	return true
end
function c511001957.repval(e,c)
	return c==e:GetLabelObject()
end
function c511001957.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE+REASON_EFFECT)~=0
end
