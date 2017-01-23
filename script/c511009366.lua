--Spirit Tech Force - Pendulum Governor
function c511009366.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--Back to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65518099,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511009366.thtg)
	e1:SetOperation(c511009366.thop)
	c:RegisterEffect(e1)
	
	--cannot be battle target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c511009366.atlimit)
	c:RegisterEffect(e2)
	
	--cannot attack
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetTarget(c511009366.atlimit2)
	c:RegisterEffect(e3)
	
	--effect gain
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(25793414,1))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetTarget(c511009366.eftg)
	e4:SetOperation(c511009366.efop)
	c:RegisterEffect(e4)
	if not c511009366.global_check then
		c511009366.global_check=true
		local ge=Effect.CreateEffect(c)
		ge:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge:SetCode(EVENT_CHAINING)
		ge:SetOperation(c511009366.checkop)
		Duel.RegisterEffect(ge,0)
	end
end
function c511009366.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if tc:IsFaceup() and tc:IsType(TYPE_MONSTER) then
			tc:RegisterFlagEffect(511009366,RESET_EVENT,0,1)
		end
		tc=eg:GetNext()
	end
end
function c511009366.thfil(c)
	return c:IsSetCard(0x1414) and c:IsAbleToHand()
end
function c511009366.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009366.thfil,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,0,0)
end
function c511009366.thop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c511009366.thfil,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,tp,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c511009366.atlimit(e,c)
	local tp=e:GetHandlerPlayer()
	return c:IsControler(1-tp) and not c:IsType(TYPE_PENDULUM) and not c:IsImmuneToEffect(e)
end
function c511009366.atlimit2(e,c)
	local lsc=Duel.GetFieldCard(tp,LOCATION_SZONE,6):GetLeftScale()
	local rsc=Duel.GetFieldCard(tp,LOCATION_SZONE,7):GetRightScale()
	local lv=c:GetLevel()
	if lsc>rsc then lsc,rsc=rsc,lsc end
	return lsc and rsc and (lv>lsc and lv<rsc) and not c:IsImmuneToEffect(e)
end

function c511009366.effilter(c)
	return c:IsFaceup() and c:IsSummonType(SUMMON_TYPE_PENDULUM) and c:IsPreviousLocation(LOCATION_HAND) and c:IsSetCard(0x1414) and	c:GetFlagEffect(511009366)==0	and c:IsReleasableByEffect()
end
function c511009366.eftg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511009366.effilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009366.effilter,tp,LOCATION_MZONE,0,1,nil)
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
	local g=Duel.SelectTarget(tp,c511009366.effilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511009366.efop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) and Duel.Release(tc,REASON_EFFECT)>0 then
		e:GetHandler():RegisterFlagEffect(tc:GetCode(),RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		Duel.MajesticCopy(c,tc)
		Duel.MajesticCopy(c,tc)
	end
end

