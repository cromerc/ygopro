--Doom Gazer
function c511002128.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c511002128.condition)
	e1:SetTarget(c511002128.target)
	e1:SetOperation(c511002128.operation)
	c:RegisterEffect(e1)
end
function c511002128.condition(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsChainNegatable(ev) then return false end
	local ex,tg,tc=Duel.GetOperationInfo(ev,CATEGORY_DESTROY)
	if ex and tg~=nil and tc+tg:FilterCount(Card.IsOnField,nil)-tg:GetCount()>0 then
		e:SetLabel(tg:FilterCount(Card.IsOnField,nil))
		return true
	else
		return false
	end
end
function c511002128.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local dam=e:GetLabel()
	if chk==0 then return dam>0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam*300)
end
function c511002128.operation(e,tp,eg,ep,ev,re,r,rp)
	local dam=e:GetLabel()
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,dam*300,REASON_EFFECT)
end
