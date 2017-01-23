--No.65 裁断魔人ジャッジ・バスター
function c511010065.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,2,2)
	c:EnableReviveLimit()
	--negate activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511010065,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511010065.condition)
	e1:SetCost(c511010065.cost)
	e1:SetTarget(c511010065.target)
	e1:SetOperation(c511010065.operation)
	c:RegisterEffect(e1)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c511010065.indes)
	c:RegisterEffect(e3)
	if not c511010065.global_check then
		c511010065.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010065.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010065.xyz_number=65
function c511010065.condition(e,tp,eg,ep,ev,re,r,rp,chk)
	local loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	return rp~=tp and not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and loc==LOCATION_MZONE
		and re:IsActiveType(TYPE_MONSTER) and Duel.IsChainNegatable(ev)
end
function c511010065.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010065.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,500)
end
function c511010065.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateActivation(ev)
	Duel.Damage(1-tp,500,REASON_EFFECT)
end
function c511010065.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,3790062)
	Duel.CreateToken(1-tp,3790062)
end
function c511010065.indes(e,c)
return not c:IsSetCard(0x48)
end
