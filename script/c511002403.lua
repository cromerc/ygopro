--時の魔術師
function c511002403.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MONSTER_SSET)
	e1:SetValue(TYPE_SPELL)
	c:RegisterEffect(e1)
	--Activate
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_COIN+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetTarget(c511002403.target)
	e2:SetOperation(c511002403.activate)
	c:RegisterEffect(e2)
end
function c511002403.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,LOCATION_MZONE)>0 end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_COIN,nil,0,tp,1)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511002403.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(71625222,1))
	local coin=Duel.SelectOption(tp,60,61)
	local res=Duel.TossCoin(tp,1)
	if coin~=res then
		local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(-1500)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_UPDATE_DEFENSE)
			tc:RegisterEffect(e2)
			tc=g:GetNext()
		end
		Duel.RaiseEvent(e:GetHandler(),71625222,e,0,0,tp,0)
		Duel.RaiseEvent(e:GetHandler(),71625222,e,0,0,1-tp,0)
	else
		local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
		g:AddCard(e:GetHandler())
		Duel.Destroy(g,REASON_EFFECT)
		local dg=Duel.GetOperatedGroup()
		local sum=dg:GetSum(Card.GetAttack)
		Duel.Damage(tp,sum/2,REASON_EFFECT)
	end
end
