--恋する乙女
function c100000139.initial_effect(c)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetCondition(c100000139.sdcon)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000139,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLED)
	e2:SetTarget(c100000139.target)
	e2:SetOperation(c100000139.operation)
	c:RegisterEffect(e2)
end
function c100000139.sdcon(e)
	return e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
end
function c100000139.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetAttackTarget()==e:GetHandler() end
	if Duel.GetAttacker():IsRelateToBattle() then 
	Duel.SetTargetCard(Duel.GetAttacker()) end
end
function c100000139.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		tc:AddCounter(0x90,1)
	end
end
