--インフィニティ・フォース
function c100000040.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetCondition(c100000040.regcon)
	e1:SetTarget(c100000040.rectg)
	e1:SetOperation(c100000040.recop)
	c:RegisterEffect(e1)
end
function c100000040.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3013)
end
function c100000040.regcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000040.cfilter,tp,LOCATION_MZONE,0,1,nil)
	 and ep==tp
end
function c100000040.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
end
function c100000040.recop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.Destroy(sg,REASON_EFFECT)
end
