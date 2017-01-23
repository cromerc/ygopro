--No.104 仮面魔踏士シャイニング
function c511010104.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_LIGHT),4,3)
	c:EnableReviveLimit()
	--negate activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(2061963,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511010104.condition)
	e1:SetCost(c511010104.cost)
	e1:SetTarget(c511010104.target)
	e1:SetOperation(c511010104.operation)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(2061963,1))
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c511010104.decktg)
	e2:SetOperation(c511010104.deckop)
	c:RegisterEffect(e2)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c511010104.indes)
	c:RegisterEffect(e3)
	if not c511010104.global_check then
		c511010104.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010104.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010104.xyz_number=104
function c511010104.condition(e,tp,eg,ep,ev,re,r,rp,chk)
	local ph=Duel.GetCurrentPhase()
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and ep~=tp
		and (ph>PHASE_MAIN1 and ph<PHASE_MAIN2) and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c511010104.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010104.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c511010104.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) then
		Duel.Damage(1-tp,800,REASON_EFFECT)
	end
end
function c511010104.decktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDiscardDeck(1-tp,1) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,1)
end
function c511010104.deckop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.DiscardDeck(p,d,REASON_EFFECT)
end

function c511010104.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,2061963)
	Duel.CreateToken(1-tp,2061963)
end
function c511010104.indes(e,c)
return not c:IsSetCard(0x48)
end
