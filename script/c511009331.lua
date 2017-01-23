--Performapal Ballad
function c511009331.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--lose attack 1
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000947,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511009331.atkcon)
	e1:SetOperation(c511009331.atkop)
	c:RegisterEffect(e1)
	--lose atk 2
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511009331.atkcon2)
	e2:SetOperation(c511009331.atkop2)
	c:RegisterEffect(e2)
end

function c511009331.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:GetControler()==tp and Duel.GetAttackTarget() and at:IsSetCard(0x9f)
end
function c511009331.atkop(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(-600)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	at:RegisterEffect(e1)
end


function c511009331.atkcon2(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return a and a:IsRelateToBattle() and a:IsControler(tp) and a:IsSetCard(0x9f)
end
function c511009331.atkop(e,tp,eg,ep,ev,re,r,rp)
	local atk=Duel.GetAttacker():GetAttack()
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-atk)
		tc:RegisterEffect(e1)
	end
end
