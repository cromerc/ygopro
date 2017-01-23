--No.91 サンダー・スパーク・ドラゴン
function c511002059.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,5)
	c:EnableReviveLimit()
	--destroy1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(32543380,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511002059.cost)
	e1:SetLabel(3)
	e1:SetTarget(c511002059.destg1)
	e1:SetOperation(c511002059.desop1)
	c:RegisterEffect(e1)
	--destroy2
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84417082,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511002059.cost)
	e2:SetLabel(5)
	e2:SetTarget(c511002059.destg2)
	e2:SetOperation(c511002059.desop2)
	c:RegisterEffect(e2)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c511002059.indes)
	c:RegisterEffect(e3)
	if not c511002059.global_check then
		c511002059.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511002059.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511002059.xyz_number=91
function c511002059.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=e:GetLabel()
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,ct,REASON_COST) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	e:GetHandler():RemoveOverlayCard(tp,ct,ct,REASON_COST)
end
function c511002059.destg1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c511002059.desop1(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
function c511002059.destg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_ONFIELD,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_ONFIELD,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0,nil)
end
function c511002059.desop2(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_ONFIELD,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
function c511002059.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,84417082)
	Duel.CreateToken(1-tp,84417082)
end
function c511002059.indes(e,c)
	return not c:IsSetCard(0x48)
end
