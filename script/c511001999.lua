--Number 15: Gimmick Puppet Giant Grinder (Anime)
function c511001999.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,8,2)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511001999.descost)
	e1:SetTarget(c511001999.destg)
	e1:SetOperation(c511001999.desop)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511001999.indes)
	c:RegisterEffect(e2)
	if not c511001999.global_check then
		c511001999.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511001999.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511001999.xyz_number=15
function c511001999.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511001999.filter(c)
	return (c:IsFaceup() and c:IsType(TYPE_XYZ)) or (c:IsFacedown() and c:GetOverlayCount()>0)
end
function c511001999.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001999.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(c511001999.filter,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c511001999.ctfilter(c,tp)
	return c:GetPreviousControler()==tp
end
function c511001999.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c511001999.filter,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		local dg=Duel.GetOperatedGroup()
		local g1=dg:Filter(c511001999.ctfilter,nil,tp)
		local g2=dg:Filter(c511001999.ctfilter,nil,1-tp)
		local sum1=g1:GetSum(Card.GetAttack)
		local sum2=g2:GetSum(Card.GetAttack)
		Duel.Damage(tp,sum1,REASON_EFFECT)
		Duel.Damage(1-tp,sum2,REASON_EFFECT)
	end
end
function c511001999.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,88120966)
	Duel.CreateToken(1-tp,88120966)
end
function c511001999.indes(e,c)
	return not c:IsSetCard(0x48)
end
