--Automatic Gearspring Machine
function c511009018.initial_effect(c)
	c:EnableCounterPermit(0x108)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_COUNTER)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009018.target)
	e1:SetOperation(c511009018.activate)
	c:RegisterEffect(e1)
	--counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511009018.addcon)
	e2:SetOperation(c511009018.addop)
	c:RegisterEffect(e2)
	--spsummon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(61156777,1))
	e3:SetCategory(CATEGORY_COUNTER)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c511009018.spcost)
	e3:SetTarget(c511009018.sptg)
	e3:SetOperation(c511009018.spop)
	c:RegisterEffect(e3)
end
function c511009018.addcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c511009018.addop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:AddCounter(0x108,1)
	Duel.RaiseEvent(c,95100633,e,0,tp,0,0)
end
function c511009018.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,2,0,0x108)
end
function c511009018.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		c:AddCounter(0x108,2)
		Duel.RaiseEvent(c,95100633,e,0,tp,0,0)
	end
end

function c511009018.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	e:SetLabel(e:GetHandler():GetCounter(0x108))
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511009018.filter(c,e,tp)
	return c:IsFaceup() and c:IsCanAddCounter(0x108,1)
end
function c511009018.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local c=e:GetHandler()
		local ct=c:GetCounter(0x108)
		return ct>0 and Duel.IsExistingMatchingCard(Card.IsCanAddCounter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c,0x108,ct)
	end
	Duel.SetTargetParam(e:GetLabel())
	e:SetLabel(0)
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,ct,0,0x108)
end
function c511009018.spop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(73853830,1))
	local g=Duel.SelectMatchingCard(tp,Card.IsCanAddCounter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil,0x108,ct)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		tc:AddCounter(0x108,ct)
		Duel.RaiseEvent(tc,95100633,e,0,tp,0,0)
	end
end
