--Zombie's Jewel
function c511000170.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c511000170.condition)
	e1:SetTarget(c511000170.target)
	e1:SetOperation(c511000170.activate)
	c:RegisterEffect(e1)
end
function c511000170.filter(c,tp)
	return c:IsControler(1-tp) and c:IsAbleToHand() and c:IsType(TYPE_SPELL)
end
function c511000170.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000170.filter,nil,tp)
	return g:GetCount()==1
end
function c511000170.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c511000170.filter,nil,tp)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp,1) end
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,1)
end
function c511000170.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,tp,REASON_EFFECT)
		Duel.Draw(1-tp,1,REASON_EFFECT)
	end
end
