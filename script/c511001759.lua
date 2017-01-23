--Meteor Stream
function c511001759.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511001759.damcon)
	e1:SetTarget(c511001759.damtg)
	e1:SetOperation(c511001759.damop)
	c:RegisterEffect(e1)
	if not c511001759.global_check then
		c511001759.global_check=true
		c511001759[0]=Group.CreateGroup()
		c511001759[0]:KeepAlive()
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetCode(EVENT_TO_GRAVE)
		ge1:SetOperation(c511001759.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511001759.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001759.cfilter(c)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_RELEASE)
end
function c511001759.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511001759.cfilter,nil)
	if g:GetCount()>0 then
		c511001759[0]:Merge(g)
	end
end
function c511001759.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001759[0]:Clear()
end
function c511001759.gfilter(c)
	return c511001759[0]:IsContains(c)
end
function c511001759.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511001759.gfilter,1,nil)
end
function c511001759.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,1000)
end
function c511001759.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
