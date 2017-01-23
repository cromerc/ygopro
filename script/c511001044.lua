--DD魔導賢者ケプラー
function c511001044.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--scale change
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetDescription(aux.Stringid(511001044,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCountLimit(1)
	e2:SetCondition(c511001044.sccon)
	e2:SetTarget(c511001044.sctg)
	e2:SetOperation(c511001044.scop)
	c:RegisterEffect(e2)
	--return to hand
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001044,1))
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetTarget(c511001044.thtg)
	e3:SetOperation(c511001044.thop)
	c:RegisterEffect(e3)
end
function c511001044.sccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c511001044.filter(c,lv)
	return c:IsFaceup() and c:IsAbleToGrave() and c:IsLevelBelow(lv) and c:GetSummonType()==SUMMON_TYPE_PENDULUM
end
function c511001044.sctg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local scl=e:GetHandler():GetLeftScale()-5
	local g=Duel.GetMatchingGroup(c511001044.filter,tp,LOCATION_MZONE,0,nil,sc1)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c511001044.scop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local scl=c:GetLeftScale()-5
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_LSCALE)
	e1:SetValue(scl)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CHANGE_RSCALE)
	c:RegisterEffect(e2)
	local g=Duel.GetMatchingGroup(c511001044.filter,tp,LOCATION_MZONE,0,nil,scl)
	if g:GetCount()>0 then
		Duel.BreakEffect()
		Duel.SendtoGrave(g,REASON_EFFECT)
	end
end
function c511001044.thfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function c511001044.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001044.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001044.thfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,c511001044.thfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c511001044.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
