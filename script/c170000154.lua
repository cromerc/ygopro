--ミラーフォース・ドラゴン
function c170000154.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,11082056,44095762,false,false)
	--Mirror Force Power!
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(c170000154.con)
	e1:SetTarget(c170000154.tg)
	e1:SetOperation(c170000154.op)
	c:RegisterEffect(e1)
end
c170000154.material_trap=44095762
function c170000154.con(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=Duel.GetAttacker()
	if bc==c then bc=Duel.GetAttackTarget() end
	return bc and bc:IsFaceup() and bc:GetAttack()>=c:GetAttack()
end
function c170000154.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c170000154.filter1(c,atk)
	return c:IsFaceup() and c:GetAttack()<atk
end
function c170000154.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local atk=c:GetAttack()
	local dg=Duel.GetMatchingGroup(c170000154.filter1,tp,0,LOCATION_MZONE,nil,atk)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	local tc=dg:GetFirst()
	local dam=0
	while tc do
		local dif=atk-tc:GetAttack()
		dam=dam+dif
		tc=dg:GetNext()
	end
	Duel.Damage(1-tp,dam,REASON_BATTLE)
	Duel.Destroy(g,REASON_EFFECT)
end
