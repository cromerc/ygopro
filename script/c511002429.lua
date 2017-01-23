--Spirit Sword of Sealing
function c511002429.initial_effect(c)
	--remove
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511002429.target)
	e1:SetOperation(c511002429.activate)
	c:RegisterEffect(e1)
	--remain field
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_REMAIN_FIELD)
	c:RegisterEffect(e2)
end
function c511002429.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToRemove() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,Card.IsAbleToRemove,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c511002429.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and Duel.Remove(tc,tc:GetPosition(),REASON_EFFECT+REASON_TEMPORARY)~=0 then
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x9fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+0x9fe0000)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD)
		e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e3:SetRange(LOCATION_SZONE)
		e3:SetTargetRange(1,1)
		e3:SetLabelObject(tc)
		e3:SetCondition(aux.nfbdncon)
		e3:SetTarget(c511002429.sumlimit)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e4:SetRange(LOCATION_SZONE)
		e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e4:SetValue(c511002429.indesval)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e4)
		local e5=Effect.CreateEffect(c)
		e5:SetProperty(EFFECT_FLAG_DELAY)
		e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e5:SetCode(EVENT_TO_GRAVE)
		e5:SetRange(LOCATION_SZONE)
		e5:SetLabelObject(tc)
		e5:SetLabel(tc:GetOwner())
		e5:SetCondition(c511002429.retcon)
		e5:SetTarget(c511002429.rettg)
		e5:SetOperation(c511002429.retop)
		e5:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e5)
	end
end
function c511002429.filter(c,tp)
	return c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp
		and c:GetControler()==tp and c:IsReason(REASON_DESTROY) and c:GetOwner()==tp
end
function c511002429.retcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511002429.filter,1,nil,e:GetLabel())
end
function c511002429.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetLabelObject()
	if chk==0 then return tc and e:GetHandler():IsRelateToEffect(e) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c511002429.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if c:IsRelateToEffect(e) then
		Duel.ReturnToField(tc)
		Duel.Destroy(c,REASON_EFFECT)		
		tc:ResetEffect(RESET_MSCHANGE,RESET_EVENT)
	end
end
function c511002429.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return e:GetLabelObject()==c
end
function c511002429.indesval(e,re)
	return re:GetOwner()~=e:GetOwner()
end
