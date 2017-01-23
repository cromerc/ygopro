--Tribute Ticket
function c511001570.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001570.retcost)
	c:RegisterEffect(e1)
	--summon proc
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(11370031,0))
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SUMMON_PROC)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(LOCATION_HAND,0)
	e4:SetCondition(c511001570.sumcon)
	e4:SetOperation(c511001570.sumop)
	e4:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_SET_PROC)
	c:RegisterEffect(e5)
end
function c511001570.retcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c511001570.sumcon(e,c)
	if c==nil then return e:GetHandler():IsReleasable() end
	local mi,ma=c:GetTributeRequirement()
	return ma>1 and mi>1 and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
function c511001570.sumop(e,tp,eg,ep,ev,re,r,rp,c)
	Duel.Release(e:GetHandler(),REASON_COST)
end
