--ナイト・バタフライ・アサシン
function c511002763.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2191144,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511002763.atkcon)
	e1:SetCost(c511002763.atkcost)
	e1:SetTarget(c511002763.atktg)
	e1:SetOperation(c511002763.atkop)
	c:RegisterEffect(e1)
end
function c511002763.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget() and (Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()) 
		and (Duel.GetAttacker()==e:GetHandler() or Duel.GetAttackTarget()==e:GetHandler())
end
function c511002763.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) 
		and e:GetHandler():GetFlagEffect(511002763)==0 end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
	e:GetHandler():RegisterFlagEffect(511002763,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_DAMAGE,0,1)
end
function c511002763.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetOverlayCount(tp,1,1)>1 end
end
function c511002763.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local ct=Duel.GetOverlayCount(tp,1,1)
		if ct>0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(ct*400)
			e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
			c:RegisterEffect(e1)
		end
	end
end
