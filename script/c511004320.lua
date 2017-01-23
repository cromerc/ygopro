--ローガーディアン a.k.a Skull Guardian (DOR)
function c511004320.initial_effect(c)
	--flip effect & atkchange
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511004320,0))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c511004320.operation)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c511004320.condtion)
	e2:SetValue(900)
	c:RegisterEffect(e2)
end
function c511004320.condtion(e)
	local ph=Duel.GetCurrentPhase()
	if not (ph==PHASE_DAMAGE or ph==PHASE_DAMAGE_CAL) or not e:GetHandler():IsRelateToBattle() then return false end
	local bc=e:GetHandler():GetBattleTarget()
	return bc and bc:IsFaceup() and bc:IsRace(RACE_FIEND)
end
function c511004320.atktg(e,c)
	return c:GetFieldID()<=e:GetLabel() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c511004320.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,LOCATION_MZONE)
		local mg,fid=g:GetMaxGroup(Card.GetFieldID)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
		e1:SetTarget(c511004320.atktg)
		e1:SetValue(300)
		e1:SetLabel(fid)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end



