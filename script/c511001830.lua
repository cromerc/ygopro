--Battle Gravity
function c511001830.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(79580323,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511001830.damcon)
	e2:SetTarget(c511001830.damtg)
	e2:SetOperation(c511001830.damop)
	c:RegisterEffect(e2)
	if not c511001830.global_check then
		c511001830.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ATTACK_ANNOUNCE)
		ge1:SetOperation(c511001830.check)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ATTACK_DISABLED)
		ge2:SetOperation(c511001830.check2)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001830.filter(c)
	local ct=c:GetFlagEffectLabel(51101830)
	return not ct or ct==0
end
function c511001830.damcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001830.filter,Duel.GetTurnPlayer(),LOCATION_MZONE,0,1,nil)
end
function c511001830.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(Duel.GetTurnPlayer())
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,Duel.GetTurnPlayer(),1000)
end
function c511001830.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511001830.check(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local ct=tc:GetFlagEffectLabel(51101830)
	if ct then
		tc:SetFlagEffectLabel(51101830,ct+1)
	else
		tc:RegisterFlagEffect(51101830,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,1)
	end
end
function c511001830.check2(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local ct=tc:GetFlagEffectLabel(51101830)
	if ct then
		tc:SetFlagEffectLabel(51101830,ct-1)
	end
end
