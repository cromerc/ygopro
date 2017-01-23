--BF－孤高のシルバー・ウィンド
function c511001954.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x33),aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95100014,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c511001954.descost)
	e1:SetTarget(c511001954.destg)
	e1:SetOperation(c511001954.desop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c511001954.indtg)
	e2:SetCountLimit(1)
	e2:SetValue(aux.TRUE)
	c:RegisterEffect(e2)
end
function c511001954.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetAttackAnnouncedCount()==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
	e:GetHandler():RegisterEffect(e1)
end
function c511001954.filter(c,atk)
	return c:IsFaceup() and c:GetDefense()<=atk and c:IsDestructable()
end
function c511001954.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001954.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,e:GetHandler():GetAttack()) end
	local g=Duel.GetMatchingGroup(c511001954.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,e:GetHandler():GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c511001954.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c511001954.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,2,nil,e:GetHandler():GetAttack())
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
function c511001954.indtg(e,c)
	return c:IsFaceup() and c:IsSetCard(0x33)
end
