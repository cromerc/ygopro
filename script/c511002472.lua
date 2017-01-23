--Ant Barrier
function c511002472.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002472.target)
	c:RegisterEffect(e1)
	--negate
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000047,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511002472.atkcon)
	e2:SetTarget(c511002472.atktg)
	e2:SetOperation(c511002472.atkop)
	c:RegisterEffect(e2)
	--Negate Damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_HAND)
	e3:SetCondition(c511002472.discon)
	e3:SetTarget(c511002472.distg)
	e3:SetOperation(c511002472.disop)
	c:RegisterEffect(e3)
end
function c511002472.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local a=Duel.GetAttacker()
	if Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and c511002472.atkcon(e,tp,Group.FromCards(a),ep,ev,re,r,rp) 
		and c511002472.atktg(e,tp,Group.FromCards(a),ep,ev,re,r,rp,0) 
		and Duel.SelectYesNo(tp,aux.Stringid(61965407,1)) then
		e:SetOperation(c511002472.atkop)
		c511002472.atktg(e,tp,Group.FromCards(a),ep,ev,re,r,rp,1)
	else
		e:SetOperation(nil)
	end
end
function c511002472.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(1-tp)
end
function c511002472.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() and e:GetHandler():GetFlagEffect(511002472)==0 end
	Duel.SetTargetCard(tg)
	e:GetHandler():RegisterFlagEffect(511002472,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c511002472.atkop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsAttackable() and not tc:IsStatus(STATUS_ATTACK_CANCELED) then
		Duel.NegateAttack()
	end
end
function c511002472.discon(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsActiveType(TYPE_MONSTER) or ep==tp then return false end
	return aux.damcon1(e,tp,eg,ep,ev,re,r,rp)
end
function c511002472.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 end
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	c:CreateEffectRelation(e)
end
function c511002472.disop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(cid)
	e1:SetValue(c511002472.refcon)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
	local g=Duel.GetMatchingGroup(c511002472.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	end
end
function c511002472.filter(c)
	return not c:IsPosition(POS_FACEUP_DEFENSE)
end
function c511002472.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cid==e:GetLabel() then e:SetLabel(val) return 0
	else return val end
end
