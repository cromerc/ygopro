--Action Card - Quiz - 500 of Riddle
function c95000092.initial_effect(c)
	--Activate/Answer
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95000092.target)
	e1:SetOperation(c95000092.activate)
	c:RegisterEffect(e1)
end
function c95000092.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local op=Duel.SelectOption(tp,aux.Stringid(95000092,0),aux.Stringid(95000092,1),aux.Stringid(95000092,2),aux.Stringid(95000092,3))
	e:SetLabel(op)
end
function c95000092.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
	Duel.Recover(tp,500,REASON_EFFECT)
	elseif e:GetLabel()==1 then
	Duel.Damage(tp,500,REASON_EFFECT)
	elseif e:GetLabel()==2 then
	Duel.Damage(tp,500,REASON_EFFECT)
	elseif e:GetLabel()==3 then
	Duel.Damage(tp,500,REASON_EFFECT)
	end
end