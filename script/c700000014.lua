--Scripted by Eerie Code
--Abyss Actor - Funky Comedian
function c700000014.initial_effect(c)
	--Pendulum Summon
	aux.EnablePendulumAttribute(c)
	--Increase ATK (P)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c700000014.atkcost)
	e2:SetTarget(c700000014.atktg)
	e2:SetOperation(c700000014.atkop)
	c:RegisterEffect(e2)
	--Reduce ATK (M)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_SUMMON_SUCCESS)
	e3:SetOperation(c700000014.atkop2)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e4)
end
function c700000014.cfilter(c,tp)
	return c:IsType(TYPE_PENDULUM) and c:IsSetCard(0x10ec) and c:IsAbleToDeckOrExtraAsCost() 
		and Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,c)
end
function c700000014.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c700000014.cfilter,tp,LOCATION_MZONE,0,1,nil,tp) end
	local g=Duel.SelectMatchingCard(tp,c700000014.cfilter,tp,LOCATION_MZONE,0,1,1,nil,tp)
	local atk=g:GetFirst():GetAttack()
	if atk<0 then atk=0 end
	e:SetLabel(atk)
	Duel.SendtoExtraP(g,nil,REASON_COST)
end
function c700000014.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c700000014.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c700000014.atkfil(c)
	return c:IsFaceup() and c:IsSetCard(0x10ec)
end
function c700000014.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local gc=Duel.GetMatchingGroupCount(c700000014.atkfil,tp,LOCATION_MZONE,0,nil)
	if c:IsFacedown() or not c:IsRelateToEffect(e) then return end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(gc*300)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
end
