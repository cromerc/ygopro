--Recycle Rhinobot
function c511002778.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,c511002778.mfilter,4,3)
	c:EnableReviveLimit()
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(10613952,1))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511002778.atkcost)
	e1:SetTarget(c511002778.atktg)
	e1:SetOperation(c511002778.atkop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(96470883,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511002778.descon)
	e2:SetTarget(c511002778.destg)
	e2:SetOperation(c511002778.desop)
	c:RegisterEffect(e2)
end
function c511002778.mfilter(c)
	return c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_EARTH)
end
function c511002778.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511002778.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc:IsFaceup() and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
end
function c511002778.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(500)
		tc:RegisterEffect(e1)
	end
end
function c511002778.descon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():GetOverlayCount()==0
end
function c511002778.filter(c)
	return c:IsFaceup() and c:IsDestructable()
end
function c511002778.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c511002778.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
		local tg=g:GetMinGroup(Card.GetAttack)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
	end
end
function c511002778.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002778.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()>0 then
		local tg=g:GetMinGroup(Card.GetAttack)
		local sc
		if tg:GetCount()>1 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
			sc=tg:Select(tp,1,1,nil):GetFirst()
		else
			sc=tg:GetFirst()
		end
		if Duel.Destroy(sc,REASON_EFFECT)==0 then return end
		local atk=sc:GetBaseAttack()
		Duel.Damage(1-tp,atk,REASON_EFFECT,true)
		Duel.Damage(tp,atk,REASON_EFFECT,true)
		Duel.RDComplete()
	end
end
