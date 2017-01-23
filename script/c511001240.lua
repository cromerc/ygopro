--Upshift
function c511001240.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511001240.target)
	e1:SetOperation(c511001240.activate)
	c:RegisterEffect(e1)
end
function c511001240.cfilter(c,lv)
	return c:IsFaceup() and c:GetLevel()>lv
end
function c511001240.filter1(c,e,tp)
	local lv=c:GetLevel()
	return lv>0 and c:IsFaceup() and not Duel.IsExistingMatchingCard(c511001240.cfilter,tp,LOCATION_MZONE,0,1,nil,lv)
end
function c511001240.filter2(c)
	return c:IsFaceup() and not c:IsType(TYPE_XYZ)
end
function c511001240.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511001240.filter1(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511001240.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001240.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
end
function c511001240.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local g=Duel.GetMatchingGroup(c511001240.filter2,tp,LOCATION_MZONE,0,nil)
		local lc=g:GetFirst()
		local lv=tc:GetLevel()
		while lc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetValue(lv)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			lc:RegisterEffect(e1)
			lc=g:GetNext()
		end
	end
end
