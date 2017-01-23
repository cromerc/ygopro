--Necro Jar
function c511000175.initial_effect(c)
	--immune spell
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c511000175.efilter)
	c:RegisterEffect(e1)
	--reg
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_AVAILABLE_BD)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetOperation(c511000175.regop)
	c:RegisterEffect(e2)
end
function c511000175.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
function c511000175.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=math.floor(ev/300)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000175,0))
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetTarget(c511000175.dtg)
	e1:SetOperation(c511000175.dop)
	e1:SetLabel(ct)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	c:RegisterEffect(e1)
end
function c511000175.dtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,e:GetLabel())
end
function c511000175.dop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.DiscardDeck(p,d,REASON_EFFECT)
end
