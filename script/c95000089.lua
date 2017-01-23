--Action Card - Quiz - 200 of Mathematics
function c95000089.initial_effect(c)
	--Activate/Answer
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95000089.target)
	e1:SetOperation(c95000089.activate)
	c:RegisterEffect(e1)
end
function c95000089.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local op=Duel.SelectOption(tp,aux.Stringid(95000089,0),aux.Stringid(95000089,1),aux.Stringid(95000089,2),aux.Stringid(95000089,3))
	e:SetLabel(op)
end
function c95000089.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
	Duel.Damage(tp,200,REASON_EFFECT)
	elseif e:GetLabel()==1 then
	Duel.Damage(tp,200,REASON_EFFECT)
	elseif e:GetLabel()==2 then
	Duel.Damage(tp,200,REASON_EFFECT)
	elseif e:GetLabel()==3 then
	Duel.Recover(tp,200,REASON_EFFECT)
	end
end