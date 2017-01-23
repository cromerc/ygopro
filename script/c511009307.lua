--Ancient Gear Devil (Anime)
function c511009307.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0x7),2,true)	
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5014629,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c511009307.damtg)
	e1:SetOperation(c511009307.damop)
	c:RegisterEffect(e1)
	--Unaffected by Opponent Card Effects
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetCondition(c511009307.eqcon)
	e2:SetValue(c511009307.unval)
	c:RegisterEffect(e2)
end
function c511009307.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL)
end
function c511009307.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009307.filter,tp,LOCATION_ONFIELD,0,1,nil) end
	local ct=Duel.GetMatchingGroupCount(c511009307.filter,tp,LOCATION_ONFIELD,0,nil)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(ct*1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,ct*1000)
end
function c511009307.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c511009307.filter,tp,LOCATION_ONFIELD,0,nil)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Damage(p,ct*1000,REASON_EFFECT)
end
function c511009307.eqcon(e)
	return e:GetHandler():GetEquipGroup()>0
end
function c511009307.unval(e,te)
	return te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end