--Noble Spirit Beast Rampenta
function c13700031.initial_effect(c)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c13700031.target)
	e2:SetOperation(c13700031.activate)
	c:RegisterEffect(e2)
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SINGLE_RANGE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetRange(LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND+LOCATION_REMOVED)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	e1:SetCondition(c13700031.splimit)
	c:RegisterEffect(e1)
	--spsummon cost
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c13700031.sumsuc)
	c:RegisterEffect(e1)
end
function c13700031.sumsuc(e,tp,eg,ep,ev,re,r,rp)
	Duel.RegisterFlagEffect(tp,13700031,RESET_PHASE+PHASE_END,0,1)
end
function c13700031.splimit(e,c,tp,sumtp,sumpos)
	return Duel.GetFlagEffect(tp,13700031)~=0
end

function c13700031.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0xb5)  and c:IsAbleToRemove()
end
function c13700031.afilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_AQUA) and c:IsSetCard(0xb5)
end
function c13700031.tfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_THUNDER) and c:IsSetCard(0xb5)
end
function c13700031.pfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_PYRO) and c:IsSetCard(0xb5)
end
function c13700031.bfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_BEAST) and c:IsSetCard(0xb5)
end

function c13700031.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c13700031.tgfilter,tp,LOCATION_EXTRA,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_EXTRA)
end
function c13700031.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c13700031.tgfilter,tp,LOCATION_EXTRA,0,1,1,nil)
	local tc=g:GetFirst()
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)	
		if tc:IsRace(RACE_AQUA) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g1=Duel.SelectMatchingCard(tp,c13700031.afilter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoGrave(g1,REASON_EFFECT)
		end
		if tc:IsRace(RACE_THUNDER) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g1=Duel.SelectMatchingCard(tp,c13700031.tfilter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoGrave(g1,REASON_EFFECT)
		end
		if tc:IsRace(RACE_PYRO) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g1=Duel.SelectMatchingCard(tp,c13700031.pfilter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoGrave(g1,REASON_EFFECT)
		if tc:IsRace(RACE_BEAST) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g1=Duel.SelectMatchingCard(tp,c13700031.bfilter,tp,LOCATION_DECK,0,1,1,nil)
		Duel.SendtoGrave(g1,REASON_EFFECT)
		end
	end
end
