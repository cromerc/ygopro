--No.40 ギミック・パペット－ヘブンズ・ストリングス
function c511002830.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),8,2)
	c:EnableReviveLimit()
	--counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75433814,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511002830.ctcost)
	e1:SetTarget(c511002830.cttg)
	e1:SetOperation(c511002830.ctop)
	c:RegisterEffect(e1)
	--destroy & damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75433814,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511002830.descon)
	e2:SetTarget(c511002830.destg)
	e2:SetOperation(c511002830.desop)
	c:RegisterEffect(e2)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c511002830.indes)
	c:RegisterEffect(e3)
	if not c511002830.global_check then
		c511002830.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511002830.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511002830.xyz_number=40
function c511002830.ctcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511002830.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
end
function c511002830.ctop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	local tc=g:GetFirst()
	while tc do
		tc:AddCounter(0x1024,1)
		tc=g:GetNext()
	end
	Duel.RegisterFlagEffect(tp,511002830,RESET_PHASE+PHASE_END,0,2)
end
function c511002830.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,511002830)~=0 and Duel.GetTurnPlayer()~=tp
end
function c511002830.desfilter(c)
	return c:GetCounter(0x1024)~=0 and c:IsDestructable()
end
function c511002830.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002830.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(c511002830.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c511002830.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002830.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
	local dg=Duel.GetOperatedGroup()
	local tc=dg:GetFirst()
	local dam1=0
	local dam2=0
	while tc do
		local atk=tc:GetTextAttack()
		if atk<0 then atk=0 end
		if tc:GetPreviousControler()==tp then
			dam1=dam1+atk
		else
			dam2=dam2+atk
		end
		tc=dg:GetNext()
	end
	Duel.Damage(tp,dam1,REASON_EFFECT)
	Duel.Damage(1-tp,dam2,REASON_EFFECT)
end
function c511002830.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,75433814)
	Duel.CreateToken(1-tp,75433814)
end
function c511002830.indes(e,c)
	return not c:IsSetCard(0x48)
end
