--ハーピィ・レディ-鳳凰の陣-
function c100000294.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000294.condition)
	e1:SetTarget(c100000294.target)
	e1:SetOperation(c100000294.activate)
	c:RegisterEffect(e1)
end
function c100000294.filter(c)
	return c:IsFaceup() and c:IsCode(76812113) and c:GetAttackedCount()==0
	and not Duel.IsExistingMatchingCard(c100000294.cfilter2,tp,LOCATION_MZONE,0,1,nil)
end
function c100000294.cfilter2(c)
	return c:IsFaceup() and c:IsCode(76812113) and c:GetAttackedCount()~=0
end
function c100000294.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000294.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c100000294.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000294.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c100000294.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c100000294.filter,tp,LOCATION_MZONE,0,nil)
	if ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,Card.IsDestructable,tp,0,LOCATION_MZONE,1,ct,nil)
	if Duel.Destroy(g,nil,REASON_EFFECT) then
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
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_ATTACK)
		e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e1:SetTarget(c100000294.cfil)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
end
function c100000294.cfil(e,c)
	return c:IsFaceup() and c:IsSetCard(0x64)
end