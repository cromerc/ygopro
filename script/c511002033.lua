--Illusion Ninjitsu Art of Hazy Toad
function c511002033.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002033.actcon)
	c:RegisterEffect(e1)
	--Increase ATK
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_HANDES+CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(TIMING_DAMAGE_STEP)
	e2:SetCondition(c511002033.atkcon)
	e2:SetTarget(c511002033.atktg)
	e2:SetOperation(c511002033.atkop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c511002033.descon)
	c:RegisterEffect(e3)
end
function c511002033.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x2b)
end
function c511002033.actcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002033.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c511002033.descon(e)
	return not Duel.IsExistingMatchingCard(c511002033.cfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c511002033.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()~=tp and ph>=0x08 and ph<=0x20 
end
function c511002033.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) 
		and Duel.IsExistingMatchingCard(c511002033.cfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
end
function c511002033.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_EFFECT+REASON_DISCARD,nil)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectMatchingCard(tp,c511002033.cfilter,tp,LOCATION_MZONE,0,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			Duel.HintSelection(g)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
			e1:SetValue(1000)
			tc:RegisterEffect(e1)
		end
	end
end
