--Mirror Prison
function c511000970.initial_effect(c)
	--cannot attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ATTACK)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetTarget(c511000970.atktarget)
	e1:SetLabel(0xFFFFCF)
	c:RegisterEffect(e1)
	--allow attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000954,0))
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_BOTH_SIDE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCost(c511000970.cost)
	e2:SetCondition(c511000970.con)
	e2:SetLabelObject(e1)
	c:RegisterEffect(e2)
end
function c511000970.atktarget(e,c)
	return c:IsRace(e:GetLabel())
end
function c511000970.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local race=e:GetLabelObject():GetLabel()
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsRace,1,nil,race) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsRace,1,1,nil,race)
	Duel.Release(g,REASON_COST)
	local subr=g:GetFirst():GetRace()
	race=race-subr
	e:GetLabelObject():SetLabel(race)
end
function c511000970.con(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_CHAINING) and e:GetHandler():GetControler()~=tp
end
