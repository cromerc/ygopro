--Gorgonic Pile
function c511002588.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c511002588.target)
	e1:SetOperation(c511002588.activate)
	c:RegisterEffect(e1)
end
function c511002588.cfilter(c)
	return c:IsFaceup() and (c:IsCode(37168514) or c:IsCode(64379261) or c:IsCode(37984162) or c:IsCode(90764875) or c:IsCode(84401683))
end
function c511002588.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_ROCK) and c:GetLevel()>0
end
function c511002588.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511002588.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002588.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c511002588.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511002588.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511002588.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local ct=Duel.GetMatchingGroupCount(c511002588.cfilter,tp,LOCATION_MZONE,0,nil)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(ct)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
