--Synchro Alliance
function c511001642.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511001642.tg)
	e1:SetOperation(c511001642.op)
	c:RegisterEffect(e1)
end
function c511001642.filter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
		and Duel.IsExistingMatchingCard(c511001642.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,1,c)
end
function c511001642.filter2(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c511001642.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511001642.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001642.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	Duel.SelectTarget(tp,c511001642.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
end
function c511001642.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local g=Duel.GetMatchingGroup(c511001642.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,tc)
		local tcg=g:GetFirst()
		while tcg do
			tcg:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000,1)
			tcg=g:GetNext()
		end
		g=Duel.GetMatchingGroup(c511001642.filter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		tcg=g:GetFirst()
		while tcg do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(Duel.GetMatchingGroupCount(Card.IsType,tcg:GetControler(),LOCATION_GRAVE,0,nil,TYPE_SYNCHRO)*600)
			tcg:RegisterEffect(e1)
			tcg=g:GetNext()
		end
	end
end
