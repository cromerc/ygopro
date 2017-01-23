--Combat Scissors Beetle
function c511000111.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c511000111.splimit)
	c:RegisterEffect(e1)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000111,0))
	e3:SetCategory(CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(aux.bdgcon)
	e3:SetTarget(c511000111.damtg)
	e3:SetOperation(c511000111.damop)
	c:RegisterEffect(e3)
end
function c511000111.splimit(e,se,sp,st)
	return se:GetHandler():IsCode(511000112)
end
function c511000111.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c511000111.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
