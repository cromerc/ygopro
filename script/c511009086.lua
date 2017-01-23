--Double Cipher
function c511009086.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009086.target)
	e1:SetOperation(c511009086.operation)
	c:RegisterEffect(e1)
end
function c511009086.filter1(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:GetOverlayCount()>0 and c:IsCode(18963306) 
end
function c511009086.filter2(c)
	return c:IsCode(18963306) 
end
function c511009086.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511009086.filter1,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(c511009086.filter1,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g1=Duel.SelectTarget(tp,c511009086.filter1,tp,LOCATION_MZONE,0,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511009086.filter2,tp,LOCATION_EXTRA,0,1,1,nil)
end
function c511009086.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc1=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc2=g:GetFirst()
	if tc1==tc2 then tc2=g:GetNext() end
	if tc1:IsFacedown() or not tc1:IsRelateToEffect(e) then return end
	local og=tc1:GetOverlayGroup()
	if og:GetCount()==0 then return end
	if Duel.SendtoGrave(og,REASON_EFFECT)~=0 then	
		Duel.SpecialSummon(tc2,0,tp,tp,true,false,POS_FACEUP)
	end
end