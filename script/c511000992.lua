--Circle of Terror
function c511000992.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(1,1)
	e2:SetLabel(0)
	e2:SetTarget(c511000992.sumlimit)
	e2:SetCondition(c511000992.condition)
	c:RegisterEffect(e2)
	--discard
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(512000006,0))
	e3:SetProperty(EFFECT_FLAG_BOTH_SIDE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c511000992.cost)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetOperation(c511000992.resop)
	e4:SetLabelObject(e2)
	c:RegisterEffect(e4)
	local e5=e2:Clone()
	e5:SetLabelObject(e2)
	e5:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e5:SetCondition(c511000992.condition2)
	c:RegisterEffect(e5)
end
function c511000992.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabel()==0
end
function c511000992.condition2(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetLabel()==1 and e:GetLabel()==0 then
		e:SetLabel(1)
	end
	if e:GetLabelObject():GetLabel()==0 and e:GetLabel()==1 then
		e:SetLabel(0)
	end
	return e:GetLabel()==0
end
function c511000992.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return c:IsLocation(LOCATION_HAND) and c:GetControler()==Duel.GetTurnPlayer()
end
function c511000992.cfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsDiscardable()
end
function c511000992.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetLabelObject():GetLabel()~=1 
		and Duel.IsExistingMatchingCard(c511000992.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,c511000992.cfilter,1,1,REASON_COST+REASON_DISCARD)
	e:GetLabelObject():SetLabel(1)
end
function c511000992.resop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetLabel()~=0 then
		e:GetLabelObject():SetLabel(0)
	end
end
