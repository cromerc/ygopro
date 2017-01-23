--Echo Mirror
function c511002554.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002554.condition)
	e1:SetTarget(c511002554.target)
	e1:SetOperation(c511002554.activate)
	c:RegisterEffect(e1)
	if not c511002554.global_check then
		c511002554.global_check=true
		c511002554[0]=true
		c511002554[1]=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DAMAGE_STEP_END)
		ge1:SetOperation(c511002554.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002554.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002554.checkop(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	if at and at:IsRelateToBattle() and not at:IsStatus(STATUS_BATTLE_DESTROYED) and at:IsDefensePos() then
		c511002554[at:GetControler()]=true
	end
end
function c511002554.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002554[0]=false
	c511002554[1]=false
end
function c511002554.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511002554[tp]
end
function c511002554.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511002554.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local g=Duel.GetDecktopGroup(p,1)
	local tc=g:GetFirst()
	Duel.Draw(p,d,REASON_EFFECT)
	Duel.ConfirmCards(1-p,tc)
	if tc and tc:IsType(TYPE_MONSTER) then
		Duel.Damage(1-tp,tc:GetLevel()*300,REASON_EFFECT)
	end
	Duel.ShuffleHand(p)
end
