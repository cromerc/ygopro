--Ｄ－ＨＥＲＯ ダークエンジェル
function c100000274.initial_effect(c)
	--discard
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetTarget(c100000274.tgtg)
	e1:SetOperation(c100000274.tgop)
	c:RegisterEffect(e1)
	--todeck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000274,1))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c100000274.tdcon)
	e2:SetTarget(c100000274.tdtg)
	e2:SetOperation(c100000274.tdop)
	c:RegisterEffect(e2)
	--control
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCategory(CATEGORY_CONTROL)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c100000274.ctcon)
	e3:SetTarget(c100000274.cttg)
	e3:SetOperation(c100000274.ctop)
	c:RegisterEffect(e3)
end
function c100000274.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,e:GetHandler(),1,0,0)
end
function c100000274.tgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and Duel.SendtoGrave(c,REASON_EFFECT+REASON_DISCARD)~=0 then
		c:RegisterFlagEffect(100000274,RESET_EVENT+0x1fe0000,0,1)
	end
end
function c100000274.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_RETURN)
end
function c100000274.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(100000274)~=0 end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c100000274.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsAbleToDeck() then
		Duel.SendtoDeck(c,1-c:GetPreviousControler(),0,REASON_EFFECT)
	end
end
function c100000274.ctcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c100000274.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,e:GetHandler(),1,0,0)
end
function c100000274.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() and not Duel.GetControl(c,1-tp) then
		if not c:IsImmuneToEffect(e) and c:IsAbleToChangeControler() then
			Duel.Destroy(c,REASON_EFFECT)
		end
	end
end
