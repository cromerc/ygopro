--幻奏の音女アリア
function c511002486.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c511002486.unregop)
	c:RegisterEffect(e1)
	--battle damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetOperation(c511002486.regop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(79491903,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DAMAGE_STEP_END)
	e3:SetCountLimit(1)
	e3:SetCondition(c511002486.damcon)
	e3:SetTarget(c511002486.damtg)
	e3:SetOperation(c511002486.damop)
	c:RegisterEffect(e3)
end
function c511002486.unregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetAttacker()==c or (Duel.GetAttackTarget() and Duel.GetAttackTarget()==c) and c:GetFlagEffect(511002486)>0 then
		c:ResetFlagEffect(511002486)
	end
end
function c511002486.regop(e,tp,eg,ep,ev,re,r,rp)
	if ep~=tp then
		e:GetHandler():RegisterFlagEffect(511002486,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
	end
end
function c511002486.damcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsHasEffect(511002486)
end
function c511002486.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c511002486.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
