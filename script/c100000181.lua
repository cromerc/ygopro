--猫だまし
function c100000181.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c100000181.condition)
	e1:SetTarget(c100000181.target)
	e1:SetOperation(c100000181.activate)
	c:RegisterEffect(e1)
end
function c100000181.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_BEAST)
end
function c100000181.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and Duel.IsExistingMatchingCard(c100000181.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c100000181.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() and tg:IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,tg,1,0,0)
end
function c100000181.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
