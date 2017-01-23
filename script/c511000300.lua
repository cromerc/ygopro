--マジック·クロニクル
function c511000300.initial_effect(c)
	c:EnableCounterPermit(0x25)
	c:SetCounterLimit(0x25,2)
	local g=Group.CreateGroup()
	g:KeepAlive()
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000300.target)
	e1:SetOperation(c511000300.activate)
	e1:SetLabelObject(g)
	c:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c511000300.ctop)
	c:RegisterEffect(e2)
	--salvage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000300,0))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c511000300.thcost)
	e3:SetTarget(c511000300.thtg)
	e3:SetOperation(c511000300.thop)
	e3:SetLabelObject(g)
	c:RegisterEffect(e3)
end
function c511000300.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP+TYPE_MONSTER) and c:IsAbleToRemove()
end
function c511000300.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511000300.filter,tp,LOCATION_DECK,0,5,nil) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,5,tp,LOCATION_DECK)
end
function c511000300.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetMatchingGroup(c511000300.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()<5 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local rg=g:Select(tp,5,5,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
	local tc=rg:GetFirst()
	while tc do
		tc:RegisterFlagEffect(511000300,RESET_EVENT+0x1fe0000,0,0)
		tc=rg:GetNext()
	end
	e:GetLabelObject():Clear()
	e:GetLabelObject():Merge(rg)
end
function c511000300.ctop(e,tp,eg,ep,ev,re,r,rp)
	if rp~=tp and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) then
		e:GetHandler():AddCounter(0x25,1)
	end
end
function c511000300.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x25,2,REASON_COST) end
	e:GetHandler():RemoveCounter(tp,0x25,2,REASON_COST)
end
function c511000300.thfilter(c)
	return c:GetFlagEffect(511000300)~=0 and c:IsAbleToHand()
end
function c511000300.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return e:GetLabelObject():IsContains(chkc) and c511000300.thfilter(chkc) end
	if chk==0 then return e:GetLabelObject():IsExists(c511000300.thfilter,1,nil) end
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_ATOHAND)
	local g=e:GetLabelObject():FilterSelect(1-tp,c511000300.thfilter,1,1,nil)
	e:GetLabelObject():Sub(g)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_REMOVED)
end
function c511000300.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	end
end
function c511000300.dfilter(c)
	return c:GetFlagEffect(511000300)~=0
end
function c511000300.damcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsStatus(STATUS_ACTIVATED)
end
