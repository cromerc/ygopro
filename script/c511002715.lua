--Earthbound Prisoner Line Walker
function c511002715.initial_effect(c)
	--resummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(54936498,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTarget(c511002715.tg)
	e1:SetOperation(c511002715.op)
	c:RegisterEffect(e1)
end
function c511002715.filter(c)
	return c:IsFaceup() and c:GetSummonLocation()==LOCATION_EXTRA
end
function c511002715.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511002715.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002715.filter,tp,0,LOCATION_MZONE,1,nil) 
		and e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511002715.filter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511002715.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.RaiseEvent(tc,EVENT_SPSUMMON_SUCCESS,e,REASON_EFFECT,tp,tc:GetControler(),ev)
		Duel.RaiseSingleEvent(tc,EVENT_SPSUMMON_SUCCESS,e,REASON_EFFECT,tp,tc:GetControler(),ev)
	end
end
