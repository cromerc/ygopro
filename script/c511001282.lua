--The Phantom Knights of Dusty Robe
function c511001282.initial_effect(c)
	--change pos
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetDescription(aux.Stringid(511001282,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511001282.con)
	e1:SetOperation(c511001282.op)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_CHANGE_POS)
	e2:SetCondition(c511001282.atkcon)
	e2:SetTarget(c511001282.atktg)
	e2:SetOperation(c511001282.atkop)
	c:RegisterEffect(e2)
end
function c511001282.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsAttackPos()
end
function c511001282.op(e,tp,eg,ep,ev,re,r,rp,chk)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE)
	end
end
function c511001282.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return bit.band(c:GetPreviousPosition(),POS_ATTACK)~=0 and c:IsFaceup() and c:IsDefensePos()
		and re and re:GetOwner()==e:GetOwner()
end
function c511001282.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x204)
end
function c511001282.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001282.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001282.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001282.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001282.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(800)
		tc:RegisterEffect(e1)
	end
end
