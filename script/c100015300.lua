--
function c100015300.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW+CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c100015300.cost)
	e1:SetTarget(c100015300.target)
	e1:SetOperation(c100015300.activate)
	c:RegisterEffect(e1)
end
function c100015300.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,100015300)==0 end
	local dg=Duel.GetDecktopGroup(tp,2)
	local tc=dg:GetFirst()	
	if not tc or not tc:IsAbleToRemove() then return end
	Duel.DisableShuffleCheck()
	Duel.Remove(dg,POS_FACEUP,REASON_COST)
	Duel.RegisterFlagEffect(tp,100015300,RESET_PHASE+PHASE_END,EFFECT_FLAG_OATH,1)
end
function c100015300.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,4) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c100015300.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
