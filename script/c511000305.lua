--Photon Wind
function c511000305.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000305,0))
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511000305.atcon)
	e1:SetTarget(c511000305.attg)
	e1:SetOperation(c511000305.atop)
	c:RegisterEffect(e1)
end
function c511000305.atcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	local rc=eg:GetFirst()
	return ep~=tp and rc~=e:GetHandler() and rc:IsControler(tp) and at and at:IsRelateToBattle() and not at:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c511000305.attg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511000305.atop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Damage(p,d,REASON_EFFECT) then
		Duel.BreakEffect()
		Duel.Draw(tp,1,REASON_EFFECT)
	end
end
