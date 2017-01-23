--聖なるバリア－ミラーフォース－
function c513000001.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(c513000001.condition)
	e1:SetTarget(c513000001.target)
	e1:SetOperation(c513000001.activate)
	c:RegisterEffect(e1)
end
function c513000001.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c513000001.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAttackPos,tp,0,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAttackPos,tp,0,LOCATION_MZONE,nil)
	local sum=g:GetSum(Card.GetAttack)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(sum)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,sum)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c513000001.dfilter(c)
	return c:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)~=1
end
function c513000001.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(Card.IsAttackPos,tp,0,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		local sum=g:GetSum(Card.GetAttack)
		Duel.Damage(p,sum,REASON_BATTLE)
		local dg=g:Filter(c513000001.dfilter,nil)
		if Duel.Destroy(dg,REASON_BATTLE)~=dg:GetCount() then
			local sg=dg:Filter(Card.IsLocation,nil,LOCATION_MZONE)
			Duel.SendtoGrave(sg,REASON_BATTLE)
		end
		local tc=dg:GetFirst()
		while tc do
			tc:SetStatus(STATUS_BATTLE_DESTROYED,true)
			Duel.RaiseSingleEvent(tc,EVENT_BATTLE_DESTROYED,e,REASON_BATTLE,tp,tp,0)
			tc=dg:GetNext()
		end
		Duel.RaiseEvent(dg,EVENT_BATTLE_DESTROYED,e,REASON_BATTLE,tp,tp,0)
	end
end
