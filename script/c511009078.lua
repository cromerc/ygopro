 --Overlay Breast Armor
function c511009078.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
		
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c511009078.reptg)
	e3:SetValue(c511009078.repval)
	e3:SetOperation(c511009078.repop)
	c:RegisterEffect(e3)
end


--------------------------------------------
function c511009078.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp)  and c:IsReason(REASON_BATTLE) and c:IsLocation(LOCATION_MZONE) and c:IsSetCard(0xba) and c:CheckRemoveOverlayCard(tp,1,REASON_EFFECT)
end
function c511009078.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511009078.repfilter,1,nil,tp) end
	if Duel.SelectYesNo(tp,aux.Stringid(25341652,1)) then
		local g=eg:Filter(c511009078.repfilter,nil,tp)
		Duel.SetTargetCard(g)
		return true
	else return false end
end
function c511009078.repval(e,c)
	return c511009078.repfilter(c,e:GetHandlerPlayer())
end
function c511009078.repop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	while tc do
		tc:RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		tc=g:GetNext()
	end
end

