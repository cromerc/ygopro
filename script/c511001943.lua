--Bee Force - Dart the Pursuit
function c511001943.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetDescription(aux.Stringid(511001943,0))
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511001943.damcon)
	e1:SetTarget(c511001943.damtg)
	e1:SetCost(c511001943.damcost)
	e1:SetOperation(c511001943.damop)
	c:RegisterEffect(e1)
end
function c511001943.damcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	return tc:IsRelateToBattle() and tc:IsStatus(STATUS_OPPO_BATTLE) and tc:IsControler(tp) and tc:IsSetCard(0x214)
		and bc:IsLocation(LOCATION_GRAVE) and bc:IsReason(REASON_BATTLE)
end
function c511001943.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511001943.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	local atk=eg:GetFirst():GetBattleTarget():GetPreviousAttackOnField()
	if atk<0 then atk=0 end
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c511001943.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
