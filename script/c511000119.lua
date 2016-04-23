----Dark Sanctuary
function c511000119.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--atk change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000119,0))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_COIN)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511000119.atkcon)
	e2:SetTarget(c511000119.atktg2)
	e2:SetOperation(c511000119.atkop)
	c:RegisterEffect(e2)
	--to hand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetDescription(aux.Stringid(511000119,0))
	e3:SetType(EFFECT_TYPE_QUICK_F)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetRange(LOCATION_GRAVE+LOCATION_DECK)
	e3:SetCondition(c511000119.cond)
	e3:SetTarget(c511000119.thtg)
	e3:SetOperation(c511000119.thop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetDescription(aux.Stringid(511000119,0))
	e4:SetType(EFFECT_TYPE_QUICK_F)
	e4:SetCode(EVENT_BATTLE_DESTROYED)
	e4:SetRange(LOCATION_GRAVE+LOCATION_DECK)
	e4:SetCondition(c511000119.cond)	
	e4:SetTarget(c511000119.thtg)
	e4:SetOperation(c511000119.thop)
	c:RegisterEffect(e4)		
end

function c511000119.cfilter(c,tp)
	return c:IsCode(31829185) and c:GetPreviousControler()==tp
end
function c511000119.cond(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000119.cfilter,1,nil,tp)
end

function c511000119.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
		and Duel.IsExistingMatchingCard(c511000119.dfilter,tp,LOCATION_GRAVE,0,1,nil)
end

function c511000119.dfilter(c)
	return c:IsCode(31829185)
end

function c511000119.atktg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	e:SetLabel(1)
	Duel.SetTargetCard(Duel.GetAttacker())
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
end
function c511000119.atkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 or not e:GetHandler():IsRelateToEffect(e) then return end
	local a=Duel.GetAttacker()
	if not a:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(21598948,4))
	local coin=Duel.SelectOption(tp,aux.Stringid(21598948,2),aux.Stringid(21598948,3))
	local res=Duel.TossCoin(tp,1)
	if coin~=res then
		local atk=a:IsFaceup() and a:GetAttack() or 0
		if Duel.Destroy(a,REASON_EFFECT)>0 and atk~=0 then
			Duel.Recover(tp,atk,REASON_EFFECT) end
	 end
end

function c511000119.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c511000119.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,c)
	end
end