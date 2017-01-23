--Spirit Crystal - Salamander
function c511009367.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(81055000,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511009367.thtg1)
	e1:SetOperation(c511009367.thop1)
	c:RegisterEffect(e1)
	
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCondition(c511009367.effcon)
	e2:SetOperation(c511009367.regop)
	c:RegisterEffect(e2)
	
	
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(45591967,1))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCountLimit(1)
	
	e3:SetCondition(c511009367.descond)
	e3:SetTarget(c511009367.destg)
	e3:SetOperation(c511009367.desop)
	c:RegisterEffect(e3)
	--tohand
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetCondition(c511009367.thcon)
	e4:SetTarget(c511009367.thtg)
	e4:SetOperation(c511009367.thop)
	c:RegisterEffect(e4)
end
function c511009367.thfilter(c)
	return c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c511009367.thtg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c511009367.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009367.thfilter,tp,LOCATION_ONFIELD,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c511009367.thfilter,tp,LOCATION_ONFIELD,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c511009367.thop1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end

function c511009367.effcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	-- Debug.Message(c:IsPreviousLocation(LOCATION_HAND))
	return c:IsSummonType(SUMMON_TYPE_PENDULUM) and c:IsFaceup() and c:IsAttackPos() and c:IsPreviousLocation(LOCATION_HAND)
end
function c511009367.regop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(511009367,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end

function c511009367.desfilter(c)
	return c:IsFaceup()
end
function c511009367.descond(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(511009367)~=0
end
function c511009367.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
-- if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511009367.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,g:GetFirst():GetControler(),800)
end
function c511009367.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local p=tc:GetControler()
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.Damage(p,800,REASON_EFFECT)
		end
	end
end


function c511009367.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:GetSummonType()==SUMMON_TYPE_PENDULUM and c:IsPreviousLocation(LOCATION_EXTRA)
end
function c511009367.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsRelateToEffect(e) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c511009367.thop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) and Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)==1 then
		Duel.ConfirmCards(1-tp,e:GetHandler())
	end
end
