--真紅眼の黒炎竜
function c5637.initial_effect(c)
	aux.EnableDualAttribute(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5637,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,5637)
	e1:SetCondition(c5637.condition)
	e1:SetTarget(c5637.damtg)
	e1:SetOperation(c5637.damop)
	c:RegisterEffect(e1)
end
function c5637.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsDualState() and e:GetHandler():GetBattledGroupCount()>0
end
function c5637.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dam=e:GetHandler():GetBaseAttack()
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c5637.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local c=e:GetHandler()
	if c:IsFaceup() then
		Duel.Damage(p,d,REASON_EFFECT)
	end
end
