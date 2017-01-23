--Half Capture
function c511002800.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)	
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e1:SetCondition(c511002800.con)
	e1:SetOperation(c511002800.activate)
	c:RegisterEffect(e1)
end
function c511002800.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>0
end
function c511002800.activate(e,tp,eg,ep,ev,re,r,rp)
	local dam=Duel.GetBattleDamage(tp)/2
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c511002800.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e2:SetCountLimit(1)
	e2:SetLabel(dam)
	e2:SetOperation(c511002800.op)
	e2:SetReset(RESET_PHASE+PHASE_BATTLE)
	Duel.RegisterEffect(e2,tp)
end
function c511002800.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,ev/2)
end
function c511002800.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,511002800)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(e:GetLabel())
		tc:RegisterEffect(e1)
	end
end
