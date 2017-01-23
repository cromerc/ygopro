--SNo.39 希望皇ホープONE
function c511002001.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3,c511002001.ovfilter,aux.Stringid(86532744,1))
	c:EnableReviveLimit()
	--Banish
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_DAMAGE)
	e1:SetDescription(aux.Stringid(95100063,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c511002001.cost)
	e1:SetTarget(c511002001.target)
	e1:SetOperation(c511002001.operation)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511002001.indes)
	c:RegisterEffect(e2)
	if not c511002001.global_check then
		c511002001.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511002001.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511002001.xyz_number=39
function c511002001.ovfilter(c)
	return c:IsFaceup() and c:IsCode(84013237)
end
function c511002001.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) and Duel.GetLP(tp)>1 end
	Duel.SendtoGrave(c:GetOverlayGroup(),REASON_COST)
	Duel.SetLP(tp,1)
end
function c511002001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c511002001.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,nil)
	if Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)>0 then
		local sum=Duel.GetOperatedGroup():GetSum(Card.GetAttack)
		Duel.Damage(1-tp,sum,REASON_EFFECT)
	end
end
function c511002001.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,86532744)
	Duel.CreateToken(1-tp,86532744)
end
function c511002001.indes(e,c)
	return not c:IsSetCard(0x48)
end
