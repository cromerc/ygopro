--Blizzard Wall
function c511002182.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002182.target)
	e1:SetOperation(c511002182.activate)
	c:RegisterEffect(e1)
	if not c511002182.global_check then
		c511002182.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BE_BATTLE_TARGET)
		ge1:SetOperation(c511002182.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511002182.filter(c)
	return c:GetFlagEffect(511002182)>0
end
function c511002182.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511002182.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511002182.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectTarget(tp,c511002182.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c511002182.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_BATTLE_DESTROYED)
		e1:SetOperation(c511002182.ctop)
		tc:RegisterEffect(e1)
	end
end
function c511002182.ctop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetAttacker() and e:GetHandler():GetReasonCard() and e:GetHandler():GetReasonCard()==Duel.GetAttacker() then
		Duel.Hint(HINT_CARD,0,511002182)
		Duel.GetAttacker():AddCounter(0x1015,1,REASON_EFFECT)
	end
	e:Reset()
end
function c511002182.checkop(e,tp,eg,ep,ev,re,r,rp)
	local bt=eg:GetFirst()
	bt:RegisterFlagEffect(511002182,RESET_EVENT+0x1fc0000,0,0)
end
