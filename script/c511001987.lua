--Symmetry Rorschach
function c511001987.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(aux.bdocon)
	e1:SetOperation(c511001987.operation)
	c:RegisterEffect(e1)
end
function c511001987.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(1-tp,1)
	if g:GetCount()==0 then return end
	Duel.ConfirmCards(tp,g)
end
