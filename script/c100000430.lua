--地縛解放
function c100000430.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCost(c100000430.cost)
	e1:SetTarget(c100000430.target)
	e1:SetOperation(c100000430.activate)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
end
function c100000430.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x21) end
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x21)
	Duel.Release(g,REASON_COST)
end
function c100000430.filter(c,tp)
	return c:IsFaceup() and c:IsLevelAbove(6) and c:IsControler(1-tp)
end
function c100000430.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c100000430.filter,1,nil,tp) 
		and Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	local atk=g:GetSum(Card.GetAttack)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c100000430.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	if Duel.Destroy(sg,REASON_EFFECT)>0 then
		sg=Duel.GetOperatedGroup()
		local tc=sg:GetFirst()
		local atk=0
		while tc do
			local oatk=tc:GetAttack()
			if oatk<0 then oatk=0 end
			atk=atk+oatk
			tc=sg:GetNext()
		end
		Duel.Damage(1-tp,atk,REASON_EFFECT)
	end
end
