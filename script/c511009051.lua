--Scarlight Red Dragon Archfiend (anime)
function c511009051.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511009051.destg)
	e2:SetOperation(c511009051.desop)
	c:RegisterEffect(e2)
end
function c511009051.filter(c,atk)
	return c:IsFaceup() and c:IsAttackBelow(atk) and bit.band(c:GetSummonType(),SUMMON_TYPE_SPECIAL)==SUMMON_TYPE_SPECIAL
		and c:IsDestructable()
end
function c511009051.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c511009051.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetAttack()) end
	local g=Duel.GetMatchingGroup(c511009051.filter,tp,LOCATION_MZONE,LOCATION_MZONE,c,c:GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetCount()*500)
end
function c511009051.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or c:IsFacedown() then return end
	local g=Duel.GetMatchingGroup(c511009051.filter,tp,LOCATION_MZONE,LOCATION_MZONE,c,c:GetAttack())
	local ct=Duel.Destroy(g,REASON_EFFECT)
	if ct>0 then
		Duel.BreakEffect()
		Duel.Damage(1-tp,ct*500,REASON_EFFECT)
	end
end
