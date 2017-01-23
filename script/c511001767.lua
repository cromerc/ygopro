--Destruction Reward
function c511001767.initial_effect(c)
	--destroyed
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c511001767.condition)
	e1:SetTarget(c511001767.target)
	e1:SetOperation(c511001767.operation)
	c:RegisterEffect(e1)
end
function c511001767.condition(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return eg:GetCount()==1 and ec:IsPreviousLocation(LOCATION_MZONE) and ec:GetPreviousControler()==1-tp
		and ec:IsReason(REASON_DESTROY) and ec:IsLevelAbove(5)
end
function c511001767.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ec=eg:GetFirst()
	local ct=0
	if ec:IsLevelAbove(7) then ct=2 else ct=1 end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,ct) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(ct)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,ct)
end
function c511001767.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
