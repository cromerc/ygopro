--Costume Box of Abyss Actor
function c511009083.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCategory(CATEGORY_EQUIP)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c511009083.target)
	e3:SetOperation(c511009083.operation)
	c:RegisterEffect(e3)
end
function c511009083.cfilter(c)
	return c:IsFaceup()
end
function c511009083.filter2(c)
	return c:IsSetCard(0x420e)
end
function c511009083.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511009083.cfilter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c511009083.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
		and Duel.IsExistingMatchingCard(c511009083.filter2,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511009083.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511009083.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local sg=Duel.SelectMatchingCard(tp,c511009083.filter2,tp,LOCATION_DECK,0,1,1,nil)
	local sc=sg:GetFirst()
	if sc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		if not Duel.Equip(tp,sc,tc,true) then return end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511009083.eqlimit)
		e1:SetLabelObject(tc)
		sc:RegisterEffect(e1)
	end
end
function c511009083.eqlimit(e,c)
	return e:GetLabelObject()==c
end
