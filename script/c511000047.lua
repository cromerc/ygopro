-- Chariot Pile
function c511000047.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000047.target)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000047,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511000047.damcon)
	e2:SetTarget(c511000047.damtg)
	e2:SetOperation(c511000047.damop)
	c:RegisterEffect(e2)
	-- pay 800
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000047,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCost(c511000047.descost)
	e3:SetCondition(c511000047.descon)
	e3:SetTarget(c511000047.destg)
	e3:SetOperation(c511000047.desop)
	c:RegisterEffect(e3)
end
function c511000047.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local a=Duel.GetAttacker()
	if Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and c511000047.descon(e,tp,Group.FromCards(a),ep,ev,re,r,rp) 
		and c511000047.descost(e,tp,Group.FromCards(a),ep,ev,re,r,rp,0) and c511000047.destg(e,tp,Group.FromCards(a),ep,ev,re,r,rp,0) 
		and Duel.SelectYesNo(tp,aux.Stringid(61965407,1)) then
		e:SetCategory(CATEGORY_DESTROY)
		e:SetProperty(0)
		e:SetOperation(c511000047.desop)
		c511000047.descost(e,tp,Group.FromCards(a),ep,ev,re,r,rp,1)
		c511000047.destg(e,tp,Group.FromCards(a),ep,ev,re,r,rp,1)
	elseif c511000047.damcon(e,tp,eg,ep,ev,re,r,rp) and c511000047.damtg(e,tp,eg,ep,ev,re,r,rp,0) 
		and Duel.SelectYesNo(tp,aux.Stringid(61965407,1)) then
		e:SetCategory(CATEGORY_DAMAGE)
		e:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e:SetOperation(c511000047.damop)
		c511000047.damtg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c511000047.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
		and (Duel.GetCurrentPhase()==PHASE_MAIN1 or Duel.GetCurrentPhase()==PHASE_MAIN2)
end
function c511000047.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(511000047)==0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(300)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,300)
	e:GetHandler():RegisterFlagEffect(511000047,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511000047.damop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511000047.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c511000047.descon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c511000047.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() and tg:IsDestructable() and e:GetHandler():GetFlagEffect(511000047)==0 end
	Duel.SetTargetCard(tg)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
	e:GetHandler():RegisterFlagEffect(511000047,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511000047.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsAttackable() and not tc:IsStatus(STATUS_ATTACK_CANCELED) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
