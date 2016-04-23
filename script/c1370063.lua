--DD Magical Sage Kepler
function c1370063.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--level up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c1370063.sccon)
	e2:SetTarget(c1370063.sctg)
	e2:SetOperation(c1370063.scop)
	c:RegisterEffect(e2)
	--cannot special summon
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(1,0)
	e3:SetTarget(c1370063.splimit)
	c:RegisterEffect(e3)
	
	--to hand
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(1370063,0))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetTarget(c1370063.target)
	e4:SetOperation(c1370063.operation)
	c:RegisterEffect(e4)
	--search
	local e5=e4:Clone()
	e5:SetDescription(aux.Stringid(1370063,1))
	e5:SetCode(EVENT_SPSUMMON_SUCCESS)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e5:SetTarget(c1370063.target2)
	e5:SetOperation(c1370063.operation2)
	c:RegisterEffect(e5)
end
function c1370063.splimit(e,c,tp,sumtp,sumpos)
	return bit.band(sumtp,SUMMON_TYPE_PENDULUM)==SUMMON_TYPE_PENDULUM and not c:IsSetCard(0xaf)
end
function c1370063.sccon(e,tp,eg,ep,ev,re,r,rp)
	local seq=e:GetHandler():GetSequence()
	if seq~=6 and seq~=7 then return false end
	return Duel.GetTurnPlayer()==tp and e:GetHandler():GetRightScale()>1
end
function c1370063.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c1370063.desfilter,tp,LOCATION_MZONE,0,nil,e:GetHandler():GetLeftScale())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c1370063.scop(e,tp,eg,ep,ev,re,r,rp)
	--scale
	local c=e:GetHandler()
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CHANGE_LSCALE)
	e4:SetReset(RESET_EVENT+0x1ff0000)
	e4:SetValue(c1370063.lsval)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_CHANGE_RSCALE)
	e5:SetValue(c1370063.rsval)
	c:RegisterEffect(e5)
	local g=Duel.GetMatchingGroup(c1370063.desfilter,tp,LOCATION_MZONE,0,nil,c:GetLeftScale())
	Duel.Destroy(g,REASON_EFFECT)
end
function c1370063.desfilter(c,p)
	return c:IsFaceup() and c:GetLevel()>=p and not (c:IsSetCard(0xaf) or c:IsType(TYPE_XYZ))
end

function c1370063.lsval(e,tp,c,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetLeftScale()-2 >=1 then
		return c:GetLeftScale()-2
	else
		return 1
	end
end
function c1370063.rsval(e,tp,c,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local c=e:GetHandler()
	if c:GetRightScale()-2 >= 1 then
		return c:GetRightScale()-2
	else
		return 1
	end
end

function c1370063.filter(c)
	return c:IsSetCard(0xaf)
end
function c1370063.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToHand() end
	if chk==0 then return Duel.IsExistingTarget(c1370063.filter,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c1370063.filter,tp,LOCATION_ONFIELD,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c1370063.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c1370063.target2(e,tp,eg,ep,ev,re,r,rp,chk)
end
function c1370063.operation2(e,tp,eg,ep,ev,re,r,rp)
end
