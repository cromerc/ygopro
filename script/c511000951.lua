--Regreatful Tuning
function c511000951.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511000951.condition)
	e1:SetTarget(c511000951.target)
	e1:SetOperation(c511000951.activate)
	c:RegisterEffect(e1)
end
function c511000951.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst():IsControler(1-tp) and ep==tp and Duel.GetAttackTarget()==nil
end
function c511000951.filter(c,e,tp)
	return c:IsType(TYPE_SYNCHRO) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000951.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:GetControler()==tp and c511000951.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511000951.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511000951.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511000951.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)~=0 then
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCountLimit(1)
		e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
		e2:SetOperation(c511000951.desop)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
	end
end
function c511000951.desop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():GetAttackedCount()>0 then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
