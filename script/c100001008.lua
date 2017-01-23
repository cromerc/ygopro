--プラズマ戦士エイトム
function c100001008.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)

	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c100001008.spcon)
	e2:SetOperation(c100001008.spop)
	c:RegisterEffect(e2)

	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e4:SetCondition(c100001008.atkcon)
	e4:SetOperation(c100001008.atkop)
	c:RegisterEffect(e4)

end
function c100001008.rfilter(c)
	return c:IsLevelAbove(7)
end
function c100001008.spcon(e,c)
	if c==nil then return true end
	return Duel.CheckReleaseGroup(c:GetControler(),c100001008.rfilter,1,nil)
end
function c100001008.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(c:GetControler(),c100001008.rfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end

function c100001008.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()==nil and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)~=0
		and e:GetHandler():GetEffectCount(EFFECT_DIRECT_ATTACK)==1
		and ep~=tp
end
function c100001008.atkop(e,tp,eg,ep,ev,re,r,rp)
	--half damage
	local c=e:GetHandler()
	Duel.ChangeBattleDamage(ep,Duel.GetBattleDamage(ep)/2)
end