--Junk Spirit
function c511000968.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511000968.con)
	e1:SetOperation(c511000968.op)
	c:RegisterEffect(e1)
end
function c511000968.filter(c,e,tp)
	return c:IsSetCard(0x43) and c:IsLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp and c:IsReason(REASON_BATTLE)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000968.con(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000968.filter,1,nil,e,tp)
end
function c511000968.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:Filter(c511000968.filter,nil,e,tp):GetFirst()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetOperation(c511000968.spop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetLabelObject(tc)
	Duel.RegisterEffect(e1,tp)
end
function c511000968.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if e:GetLabelObject():IsLocation(LOCATION_GRAVE) then
		Duel.SpecialSummon(e:GetLabelObject(),0,tp,tp,false,false,POS_FACEUP)
	end
end
