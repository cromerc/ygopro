--ギアギアタッカー
function c108140003.initial_effect(c)
	--turn set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(108140003,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c108140003.postg)
	e1:SetOperation(c108140003.posop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(108140003,1))
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_CHAIN_UNIQUE+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_FLIP)
	e2:SetTarget(c108140003.thtg)
	e2:SetOperation(c108140003.thop)
	c:RegisterEffect(e2)
end
function c108140003.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(108140003)==0 end
	c:RegisterFlagEffect(108140003,RESET_EVENT+0x1fc0000+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c108140003.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENCE)
	end
end
function c108140003.sfilter(c,tc)
	return c:IsFaceup() and c:IsSetCard(0x72) and c~=tc
end
function c108140003.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsDestructable()
end
function c108140003.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)	
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c108140003.desfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c108140003.sfilter,tp,LOCATION_MZONE,0,1,nil,e:GetHandler())
		and Duel.IsExistingTarget(c108140003.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	local count=Duel.GetMatchingGroupCount(c108140003.sfilter,tp,LOCATION_MZONE,0,nil,e:GetHandler())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c108140003.desfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,count,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c108140003.thop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
end