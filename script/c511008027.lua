--Grapple Chain
--Scripted by Snrk and Edo
function c511008027.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511008027.target)
	e1:SetOperation(c511008027.activate)
	c:RegisterEffect(e1)
end
function c511008027.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g1=Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g2=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	local fid=e:GetHandler():GetFieldID()
	g1:GetFirst():RegisterFlagEffect(511008027,RESET_EVENT+0x1fe0000,0,1,fid)
	g2:GetFirst():RegisterFlagEffect(511008028,RESET_EVENT+0x1fe0000,0,1,fid)
	e:SetLabel(fid)
	g1:Merge(g2)
	g1:KeepAlive()
	e:SetLabelObject(g1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g2,1,0,0)
end
function c511008027.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabelObject():GetCount()==2 then
		local tc1=e:GetLabelObject():Filter(function(c)return c:GetFlagEffect(511008027)>0 end,nil):GetFirst()
		local tc2=e:GetLabelObject():Filter(function(c)return c:GetFlagEffect(511008028)>0 end,nil):GetFirst()
		if not tc2 or not tc1:IsRelateToEffect(e) then return end
		if tc1:GetPosition()~=tc2:GetPosition() then
			Duel.ChangePosition(tc2,tc1:GetPosition())
		end
		c:SetCardTarget(tc2)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511008027.value)
		tc2:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetRange(LOCATION_MZONE)
		e2:SetLabelObject(tc1)
		e2:SetLabel(e:GetLabel())
		e2:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		e2:SetOperation(c511008027.changebpop)
		tc2:RegisterEffect(e2,true)
		--Debug.Message("DIS IS UEN DEE ODDA EFFAECT STATS!")
	end
end
function c511008027.value(e,c,re)
	if re~=nil then return e~=re else return false end
end
function c511008027.changebpop(e)
	local c=e:GetHandler()
	if e:GetLabelObject():GetPosition()~=c:GetPosition()
	and c:GetFlagEffectLabel(511008028)==e:GetLabel()
	and e:GetLabelObject():GetFlagEffectLabel(511008027)==e:GetLabel() then
		Duel.ChangePosition(c,e:GetLabelObject():GetPosition())
	end
end