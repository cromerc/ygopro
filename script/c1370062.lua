--DD Magical Sage Galilei
function c1370062.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1370062,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--level up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c1370062.sccon)
	e2:SetTarget(c1370062.sctg)
	e2:SetOperation(c1370062.scop)
	c:RegisterEffect(e2)
	--cannot special summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(1,0)
	e3:SetTarget(c1370062.splimit)
	c:RegisterEffect(e3)
	--return
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(1370062,1))
	e6:SetType(EFFECT_TYPE_QUICK_O)
	e6:SetCode(EVENT_FREE_CHAIN)
	e6:SetRange(LOCATION_HAND)
	e6:SetCountLimit(1,1370062)
	e6:SetCost(c1370062.cost)
	e6:SetTarget(c1370062.target)
	e6:SetOperation(c1370062.operation)
	c:RegisterEffect(e6)
end
function c1370062.splimit(e,c,tp,sumtp,sumpos)
	return bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM and not c:IsSetCard(0xaf)
end

function c1370062.sccon(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	return (seq==6 or seq==7) and Duel.GetTurnPlayer()==tp and e:GetHandler():GetRightScale()<10
end
function c1370062.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c1370062.desfilter,tp,LOCATION_MZONE,0,nil,e:GetHandler():GetLeftScale())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c1370062.scop(e,tp,eg,ep,ev,re,r,rp)
	--scale
	local c=e:GetHandler()
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CHANGE_LSCALE)
	e4:SetReset(RESET_EVENT+0x1ff0000)
	e4:SetValue(c1370062.lsval)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CHANGE_RSCALE)
	e5:SetValue(c1370062.rsval)
	c:RegisterEffect(e5)
	local g=Duel.GetMatchingGroup(c1370062.desfilter,tp,LOCATION_MZONE,0,nil,c:GetLeftScale())
	Duel.Destroy(g,REASON_EFFECT)
end
function c1370062.desfilter(c,p)
	return c:IsFaceup() and c:GetLevel()<=p and not (c:IsSetCard(0xaf) or c:IsType(TYPE_XYZ))
end

function c1370062.lsval(e,tp,c,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetLeftScale()+2 <=10 then
		return c:GetLeftScale()+2
	else
		return 10
	end
end
function c1370062.rsval(e,tp,c,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local c=e:GetHandler()
	if c:GetRightScale()+2 <=10 then
		return c:GetRightScale()+2
	else
		return 10
	end
end

function c1370062.filter(c)
	return c:IsSetCard(0xaf) or c:IsSetCard(0xae)
end
function c1370062.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c1370062.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(c1370062.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c1370062.filter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c1370062.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
