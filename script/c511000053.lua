--Synchro Back
function c511000053.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetTarget(c511000053.target)
	e1:SetOperation(c511000053.activate)
	c:RegisterEffect(e1)
end
function c511000053.tfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsAbleToExtra()
end
function c511000053.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000053.tfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000053.tfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c511000053.tfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c511000053.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local code=tc:GetOriginalCode()
	if Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)~=0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
		e1:SetCountLimit(1)
		e1:SetCondition(c511000053.spcon)
		e1:SetOperation(c511000053.spop)
		e1:SetLabel(code)
		if Duel.GetTurnPlayer()==tp then
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,2)
		else
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,1)
		end
		Duel.RegisterEffect(e1,tp)
	end
end
function c511000053.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511000053.filter2(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c511000053.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local code=e:GetLabel()
	local g=Duel.SelectMatchingCard(tp,c511000053.filter2,tp,LOCATION_EXTRA,0,1,1,nil,code,e,tp)
	if g then
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end