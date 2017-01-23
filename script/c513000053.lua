--人造人間－サイコ・ショッカー
function c513000053.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2158562,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetTarget(c513000053.destg)
	e1:SetOperation(c513000053.desop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
	--disable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e4:SetCode(EFFECT_DISABLE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e4:SetTarget(c513000053.distg)
	c:RegisterEffect(e4)
	--disable effect
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetCode(EVENT_CHAIN_SOLVING)
	e5:SetRange(LOCATION_MZONE)
	e5:SetOperation(c513000053.disop)
	c:RegisterEffect(e5)
	--disable trap monster
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e6:SetCode(EFFECT_DISABLE_TRAPMONSTER)
	e6:SetRange(LOCATION_MZONE)
	e6:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e6:SetTarget(c513000053.distg)
	c:RegisterEffect(e6)
	--self destroy
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_SELF_DESTROY)
	e7:SetRange(LOCATION_MZONE)
	e7:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e7:SetTargetRange(LOCATION_ONFIELD,LOCATION_ONFIELD)
	e7:SetTarget(c513000053.distg)
	c:RegisterEffect(e7)
end
function c513000053.filter(c)
	return c:IsType(TYPE_TRAP) and c:IsDestructable()
end
function c513000053.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c513000053.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0,nil)
end
function c513000053.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c513000053.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local sg=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	if sg:GetCount()>0 then
		Duel.ConfirmCards(1-tp,sg)
		Duel.ConfirmCards(tp,sg)
	end
	Duel.Destroy(g,REASON_EFFECT)
end
function c513000053.distg(e,c)
	return c:IsType(TYPE_TRAP)
end
function c513000053.disop(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	if re:IsActiveType(TYPE_TRAP) and rc:IsOnField() then
		Duel.NegateEffect(ev)
		if rc:IsRelateToEffect(re) then
			Duel.Destroy(eg,REASON_EFFECT)
		end
	end
end
