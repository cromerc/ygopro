--属性変化－アトリビュート・カメレオン
function c100000198.initial_effect(c)
	--Activate to Grave
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000198.target)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_SZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetCondition(c100000198.atcon)
	e2:SetTarget(c100000198.attg)
	e2:SetOperation(c100000198.atop)
	c:RegisterEffect(e2)	
end
function c100000198.target(e,tp,eg,ep,ev,re,r,rp,chk)	
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return true end
	if c100000198.atcon(e,tp,eg,ep,ev,re,r,rp) and c100000198.attg(e,tp,eg,ep,ev,re,r,rp,0) 
		and Duel.SelectYesNo(tp,aux.Stringid(65872270,0)) then
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		e:SetOperation(c100000198.atop)
		c100000198.attg(e,tp,eg,ep,ev,re,r,rp,1)
	else
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c100000198.atcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c100000198.attg(e,tp,eg,ep,ev,re,r,rp,chk)	
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) 
		and e:GetHandler():GetFlagEffect(100000198)==0 end
	e:GetHandler():RegisterFlagEffect(100000198,RESET_PHASE+PHASE_END,0,1)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)	
end
function c100000198.atop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,562)
		local rc=Duel.AnnounceAttribute(tp,1,0xffff-tc:GetAttribute())
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e1:SetValue(rc)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
