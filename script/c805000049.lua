--牙鮫帝シャーク・カイゼル
function c805000049.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunction(c,3),3,nil,nil,5)
	c:EnableReviveLimit()
	c:EnableCounterPermit(0x2e)
	c:SetCounterLimit(0x2e,99)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(805000049,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c805000049.rmcost)
	e1:SetTarget(c805000049.rmtg)
	e1:SetOperation(c805000049.rmop)
	c:RegisterEffect(e1)
	--atk/def
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c805000049.adcon)
	e2:SetValue(c805000049.adval)
	c:RegisterEffect(e2)
end
function c805000049.rmcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c805000049.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x2e)
end
function c805000049.rmop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		e:GetHandler():AddCounter(0x2e,1)
	end
end
function c805000049.adcon(e)
	local phase=Duel.GetCurrentPhase()
	return (phase==PHASE_DAMAGE or phase==PHASE_DAMAGE_CAL) and not Duel.IsDamageCalculated()
end
function c805000049.adval(e,c)
	return e:GetHandler():GetCounter(0x2e)*1000
end