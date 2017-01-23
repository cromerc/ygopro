--Overlay Buster
function c511001880.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511001880.condition)
	e1:SetTarget(c511001880.target)
	e1:SetOperation(c511001880.activate)
	c:RegisterEffect(e1)
end
function c511001880.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511001880.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001880.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetCondition(c511001880.atkcon)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(500)
		tc:RegisterEffect(e1)
		tc:RegisterFlagEffect(511001880,RESET_EVENT+0x1220000+RESET_PHASE+PHASE_END,0,1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetDescription(aux.Stringid(25123082,0))
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e2:SetCode(EVENT_BATTLED)
		e2:SetCategory(CATEGORY_DAMAGE)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
		e2:SetCondition(c511001880.shcon)
		e2:SetTarget(c511001880.shtg)
		e2:SetOperation(c511001880.shop)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
	end
end
function c511001880.atkcon(e)
	local ph=Duel.GetCurrentPhase()
	return ph>=0x08 and ph<=0x80
end
function c511001880.shcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttackTarget()
	if not tc then return false end
	if tc:IsControler(1-tp) then tc=Duel.GetAttacker() end
	local bc=tc:GetBattleTarget()
	e:SetLabelObject(bc)
	return bc:IsStatus(STATUS_BATTLE_DESTROYED) and tc:IsStatus(STATUS_OPPO_BATTLE) and bc:IsType(TYPE_XYZ) 
		and tc:GetFlagEffect(511001880)~=0 and bc:GetOverlayCount()>0
end
function c511001880.shtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetLabelObject()
	if chk==0 then return bc and bc:GetOverlayCount()>0 end
	local dam=bc:GetOverlayCount()*500
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511001880.shop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
