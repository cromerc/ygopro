--Parasitic Maneuver
--fixed by MLD
function c511009341.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511009341.target)
	e1:SetOperation(c511009341.activate)
	c:RegisterEffect(e1)
end
--OCG Parasite collection
c511009341.collection={
	[6205579]=true;
}
function c511009341.filter(c)
	return c:IsFaceup() and (c511009341.collection[c:GetCode()] or c:IsSetCard(0x410))
end
function c511009341.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511009341.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009341.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009341.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511009341.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_EXTRA_ATTACK)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e2:SetValue(1)
		tc:RegisterEffect(e2)
	end
end
