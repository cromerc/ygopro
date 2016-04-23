--Ancient Giant
function c511000126.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511000126.spcon)
	c:RegisterEffect(e1)
	--damage LP
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetOperation(c511000126.retop)
	c:RegisterEffect(e2)
end

function c511000126.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetTurnPlayer()==tp and c:GetAttackedCount()==0 then
		Duel.Damage(tp,300,REASON_EFFECT)
	end
end	

function c511000126.spfilter(c)
	return c:IsFaceup() and c:IsCode(511000122)
end
function c511000126.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_SZONE)>0 and
		Duel.IsExistingMatchingCard(c511000126.spfilter,c:GetControler(),LOCATION_SZONE,0,1,nil)
end