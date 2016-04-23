--クリアー・レイジ・ゴーレム
function c100000162.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_REMOVE_ATTRIBUTE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c100000162.ratg)
	e1:SetValue(ATTRIBUTE_DARK)
	c:RegisterEffect(e1)	
	--DAMAGE
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000162,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c100000162.condition)
	e2:SetTarget(c100000162.target)
	e2:SetOperation(c100000162.operation)
	c:RegisterEffect(e2)
end
function c100000162.ratg(e)
	return e:GetHandler()
end
function c100000162.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.GetAttackTarget()==nil
end
function c100000162.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	local dam=Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)*300
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c100000162.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
