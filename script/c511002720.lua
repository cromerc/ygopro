--Earthbound Disciple Geo Gremlina
function c511002720.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,c511002720.fusfilter,c511002720.fusfilter,true)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48009503,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511002720.descon)
	e1:SetTarget(c511002720.destg)
	e1:SetOperation(c511002720.desop)
	c:RegisterEffect(e1)
end
function c511002720.fusfilter(c)
	return c:IsSetCard(0x21f) or c:IsSetCard(0x21) or c:IsCode(67105242) or c:IsCode(67987302)
end
function c511002720.filter(c,tp)
	return c:GetPreviousControler()==1-tp and bit.band(c:GetReason(),0x41)==0x41
end
function c511002720.cfilter(tc)
	return tc and tc:IsFaceup()
end
function c511002720.descon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002720.filter,1,nil,tp) 
		and (c511002720.cfilter(Duel.GetFieldCard(tp,LOCATION_SZONE,5)) or c511002720.cfilter(Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)))
end
function c511002720.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,LOCATION_MZONE,0,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,sg:GetSum(Card.GetAttack))
end
function c511002720.desop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		local dg=Duel.GetOperatedGroup()
		local tc=dg:GetFirst()
		local dam=0
		while tc do
			local atk=tc:GetTextAttack()
			if atk<0 then atk=0 end
			dam=dam+atk
			tc=dg:GetNext()
		end
		Duel.Damage(1-tp,dam,REASON_EFFECT)
	end
end
