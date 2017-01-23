--Heraldic Beast Leo
function c511001663.initial_effect(c)
	c:EnableUnsummonable()
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetDescription(aux.Stringid(511001663,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCost(c511001663.cost)
	e1:SetTarget(c511001663.tg)
	e1:SetOperation(c511001663.op)
	c:RegisterEffect(e1)
end
function c511001663.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c511001663.filter(c)
	return c:IsFaceup() and c:GetAttack()~=c:GetBaseAttack()
end
function c511001663.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511001663.filter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g1=Duel.SelectTarget(tp,c511001663.filter,tp,LOCATION_MZONE,0,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(34016756,0))
	local g2=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
end
function c511001663.op(e,tp,eg,ep,ev,re,r,rp)
	local hc=e:GetLabelObject()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:GetFirst()
	if tc==hc then tc=g:GetNext() end
	if hc:IsFaceup() and hc:IsRelateToEffect(e) and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local atk=0
		if hc:GetBaseAttack()>hc:GetAttack() then
			atk=hc:GetBaseAttack()-hc:GetAttack()
		else
			atk=hc:GetAttack()-hc:GetBaseAttack()
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(-atk)
		tc:RegisterEffect(e1)
	end
end
