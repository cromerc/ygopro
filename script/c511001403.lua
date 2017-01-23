--Shuffle Reborn
function c511001403.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001403.condition)
	e1:SetTarget(c511001403.target)
	e1:SetOperation(c511001403.activate)
	c:RegisterEffect(e1)
end
function c511001403.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c511001403.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001403.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and c:IsControler(tp) and c511001403.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511001403.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511001403.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511001403.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
		Duel.SpecialSummonComplete()
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local g=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_ONFIELD,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			if Duel.SendtoDeck(g,nil,2,REASON_EFFECT) then
				Duel.ShuffleDeck(tp)
				local dr=Duel.GetDecktopGroup(tp,1):GetFirst()
				Duel.Draw(tp,1,REASON_EFFECT)
				local bg=Group.FromCards(tc,dr)
				bg:KeepAlive()
				local e3=Effect.CreateEffect(c)
				e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
				e3:SetCode(EVENT_PHASE+PHASE_END)
				e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
				e3:SetCountLimit(1)
				e3:SetLabelObject(bg)
				e3:SetOperation(c511001403.rmop)
				e3:SetReset(RESET_PHASE+PHASE_END)
				Duel.RegisterEffect(e3,tp)
			end
		end
	end
end
function c511001403.rmop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
