--古生代化石騎士 スカルキング
function c100000028.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c100000028.ffilter1,c100000028.ffilter2,1,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)	
	--chain attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetCondition(c100000028.atcon)
	e2:SetOperation(c100000028.atop)
	c:RegisterEffect(e2)
	--pierce
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e3)
end
function c100000028.ffilter1(c)
	return c:IsRace(RACE_ROCK) and c:GetOwner()==Duel.GetTurnPlayer()
end
function c100000028.ffilter2(c)
	return c:GetLevel()>6 and c:GetOwner()~=Duel.GetTurnPlayer() and not c:IsType(TYPE_XYZ)
end
function c100000028.atcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler()==Duel.GetAttacker() and e:GetHandler():IsChainAttackable()
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)~=0
end
function c100000028.atop(e,tp,eg,ep,ev,re,r,rp)
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EXTRA_ATTACK)	
	e3:SetCondition(c100000023.spcon)
	e3:SetValue(1)
	e:GetHandler():RegisterEffect(e3)
end
function c100000028.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(e:GetOwnerPlayer(),0,LOCATION_MZONE)>0
end