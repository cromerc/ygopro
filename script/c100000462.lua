--ＣＨ キング・アーサー
function c100000462.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunction(c,4),2)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetLabel(c:GetAttack())
	e1:SetCondition(c100000462.dmcon)
	e1:SetCost(c100000462.cost)
	e1:SetTarget(c100000462.target)
	e1:SetOperation(c100000462.operation)
	c:RegisterEffect(e1)
end
function c100000462.dmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
    local atk=c:GetAttack()
	local batk=e:GetLabel()
	return  batk~=atk and not c:IsStatus(STATUS_CHAINING)
end
function c100000462.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c100000462.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local atk=e:GetHandler():GetAttack()
	local batk=e:GetLabel()
	local dam=0
	if batk>atk then dam=batk-atk
	else dam=atk-batk end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c100000462.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
	e:SetLabel(e:GetHandler():GetAttack())
end
