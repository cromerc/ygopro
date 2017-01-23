--Dragon's Charge
function c511000352.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c511000352.condition)
	e1:SetTarget(c511000352.target)
	e1:SetOperation(c511000352.activate)
	c:RegisterEffect(e1)
end
function c511000352.cfilter(c,tp)
	local rc=c:GetReasonCard()
	return c:IsReason(REASON_BATTLE) and rc:IsRace(RACE_DRAGON) and rc:IsControler(tp) and rc:IsRelateToBattle()
end
function c511000352.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000352.cfilter,1,nil,tp)
end
function c511000352.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511000352.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	if Duel.Draw(p,d,REASON_EFFECT)>0 then
		Duel.BreakEffect()
		local tc=Duel.GetOperatedGroup():GetFirst()
		Duel.ConfirmCards(tp,tc)
		if tc:IsRace(RACE_DRAGON) and tc:IsSummonable(true,nil) then
			if Duel.SelectYesNo(tp,aux.Stringid(511000352,REASON_EFFECT)) then
				Duel.Summon(tp,tc,true,nil)
			else
				Duel.ShuffleHand(tp)
			end
		else
			Duel.ShuffleHand(tp)
		end
	end
end
