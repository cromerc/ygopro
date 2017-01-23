--Action Card - Quiz - 100 of Mathematics
function c95000086.initial_effect(c)
	--Activate/Answer
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95000086.target)
	e1:SetOperation(c95000086.activate)
	c:RegisterEffect(e1)
end
function c95000086.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local op=Duel.SelectOption(tp,aux.Stringid(95000086,0),aux.Stringid(95000086,1),aux.Stringid(95000086,2),aux.Stringid(95000086,3))
	e:SetLabel(op)
end
function c95000086.activate(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
	Duel.Damage(tp,100,REASON_EFFECT)
	elseif e:GetLabel()==1 then
	Duel.Recover(tp,100,REASON_EFFECT)
	elseif e:GetLabel()==2 then
	Duel.Damage(tp,100,REASON_EFFECT)
	elseif e:GetLabel()==3 then
	Duel.Damage(tp,100,REASON_EFFECT)
	end
end