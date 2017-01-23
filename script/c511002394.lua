--Shield Strike
function c511002394.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511002394.condition)
	e1:SetTarget(c511002394.target)
	e1:SetOperation(c511002394.activate)
	c:RegisterEffect(e1)
end
function c511002394.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and eg:GetFirst():IsControler(tp)
end
function c511002394.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(tg:GetDefense())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,tg:GetDefense())
end
function c511002394.activate(e,tp,eg,ep,ev,re,r,rp)
	local tg=Duel.GetAttacker()
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	if tg:IsRelateToBattle() then
		Duel.Damage(p,tg:GetDefense(),REASON_EFFECT)
	end
end
