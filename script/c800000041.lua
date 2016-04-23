--ＣＨ キング・アーサー
function c800000041.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunctionF(c,aux.FilterBoolFunction(Card.IsRace,RACE_WARRIOR),4),2)
	c:EnableReviveLimit()
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c800000041.reptg)
	e1:SetOperation(c800000041.atkop)
	c:RegisterEffect(e1)
end
function c800000041.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_EFFECT) and e:GetHandler():IsReason(REASON_BATTLE) end
	if Duel.SelectYesNo(tp,aux.Stringid(110000000,9)) then
		e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_EFFECT)
		e:GetHandler():RegisterFlagEffect(800000041,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		return true
	else return false end
end
function c800000041.atkop(e,tp,eg,ep,ev,re,r,rp)
	Duel.BreakEffect()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	e1:SetValue(500)
	e:GetHandler():RegisterEffect(e1)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(1-tp,500,REASON_EFFECT)
end