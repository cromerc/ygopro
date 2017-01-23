--ロード・オブ・ザ・レッド
function c511002050.initial_effect(c)
	c:EnableReviveLimit()
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_CHAIN_SOLVED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511002050.descon)
	e1:SetTarget(c511002050.destg)
	e1:SetOperation(c511002050.desop)
	c:RegisterEffect(e1)
	if not c511002050.global_check then
		c511002050.global_check=true
		c511002050[0]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAINING)
		ge1:SetOperation(c511002050.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002050.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002050.descon(e,tp,eg,ep,ev,re,r,rp)
	return c511002050[0]>1 and re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) 
end
function c511002050.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511002050.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.Destroy(sg,REASON_EFFECT)
end
function c511002050.checkop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(0,511002050)==0 and re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) then
		c511002050[0]=c511002050[0]+1
		Duel.RegisterFlagEffect(0,511002050,RESET_CHAIN,0,1)
	end
end
function c511002050.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002050[0]=0
end
