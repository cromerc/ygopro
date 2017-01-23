--キメラテック・フォートレス・ドラゴン
function c511002463.initial_effect(c)
	c:EnableReviveLimit()
	--fusion material
	aux.AddFusionProcCodeFunRep(c,70095154,aux.FilterBoolFunction(Card.IsRace,RACE_MACHINE),1,63,true,true)
	--spsummon condition
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_SPSUMMON_CONDITION)
	e2:SetValue(aux.fuslimit)
	c:RegisterEffect(e2)
	--spsummon success
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c511002463.sucop)
	c:RegisterEffect(e3)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_SPSUMMON_SUCCESS)
	e4:SetOperation(c511002463.tgop)
	c:RegisterEffect(e4)
	--attack
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetOperation(c511002463.negop)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_DAMAGE)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_ATTACK_ANNOUNCE)
	e6:SetTarget(c511002463.damtg)
	e6:SetOperation(c511002463.damop)
	c:RegisterEffect(e6)
end
function c511002463.sucop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(c:GetMaterialCount()-1)
	e1:SetReset(RESET_EVENT+0x1ff0000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	e2:SetCondition(c511002463.dircon)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_ATTACK)
	e3:SetCondition(c511002463.atkcon)
	c:RegisterEffect(e3)
end
function c511002463.dircon(e)
	return e:GetHandler():GetAttackAnnouncedCount()>0
end
function c511002463.atkcon(e)
	return e:GetHandler():IsDirectAttacked()
end
function c511002463.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_ONFIELD,0,e:GetHandler())
	Duel.SendtoGrave(g,REASON_EFFECT)
end
function c511002463.negop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateAttack()
end
function c511002463.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(400)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,400)
end
function c511002463.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
