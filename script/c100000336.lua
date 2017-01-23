--琰魔竜 レッド・デーモン
function c100000336.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000336,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c100000336.target)
	e1:SetOperation(c100000336.operation)
	c:RegisterEffect(e1)
end
function c100000336.filter(c)
	return c:IsAttackPos() and c:IsDestructable()
end
function c100000336.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000336.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler()) end
	local sg=Duel.GetMatchingGroup(c100000336.filter,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c100000336.operation(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c100000336.filter,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	local ct=sg:GetCount()
	if Duel.Destroy(sg,REASON_EFFECT)~=ct then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e:GetHandler():RegisterEffect(e1)
	end
end
