--Ｄ－フォース
function c100000270.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)	
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000270.target)
	e1:SetOperation(c100000270.activate)
	c:RegisterEffect(e1)	
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,0)
	e2:SetRange(LOCATION_DECK)
	e2:SetCode(EFFECT_SKIP_DP)
	e2:SetCondition(c100000270.sdcon)
	c:RegisterEffect(e2)	
	--disable and destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetRange(LOCATION_DECK)
	e4:SetTargetRange(LOCATION_ONFIELD,0)
	e4:SetCode(EVENT_CHAIN_SOLVING)
	e4:SetCondition(c100000270.sdcon2)
	e4:SetOperation(c100000270.disop)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetRange(LOCATION_DECK)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetCode(EVENT_ADJUST)
	e5:SetCondition(c100000270.sdcon2)
	e5:SetOperation(c100000270.sdop)
	c:RegisterEffect(e5)
end
function c100000270.tdfilter(c)
	return c:GetCode()==83965310 and c:IsFaceup()
end
function c100000270.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function c100000270.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.BreakEffect()
		c:CancelToGrave()
		Duel.SendtoDeck(c,nil,0,REASON_EFFECT)
		c:ReverseInDeck()
	end
end
function c100000270.sdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetDecktopGroup(c:GetControler(),1)
	return g:GetFirst()==c and c:IsFaceup()
end
function c100000270.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetDecktopGroup(c:GetControler(),1)
	return g:GetFirst()==c and c:IsFaceup()
	 and Duel.IsExistingMatchingCard(c100000270.tdfilter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
function c100000270.filter(c,tp)
	return c:IsLocation(LOCATION_ONFIELD) and c:IsControler(tp)
end
function c100000270.disop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp then return end
	if re:IsActiveType(TYPE_MONSTER) then return end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return false end
	local tg=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not tg or not tg:IsExists(c100000270.filter,1,nil,tp) or not Duel.IsChainDisablable(ev) then return false end
	local rc=re:GetHandler()
	Duel.NegateEffect(ev)
	if rc:IsRelateToEffect(re) then
		Duel.Destroy(rc,REASON_EFFECT)
	end
end
function c100000270.sdcon3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetDecktopGroup(c:GetControler(),1)
	return g:GetFirst():GetCode()==100000270 and g:GetFirst():IsFaceup()
end
function c100000270.tdfilter2(c)
	return c:GetCode()==83965310 and c:IsFaceup() and c:GetFlagEffect(100000270)==0
end
function c100000270.sdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c100000270.tdfilter2,tp,LOCATION_MZONE,0,nil)
	local tc=g:GetFirst()
	while tc do	
		if tc:GetFlagEffect(100000270)==0 then
			--copy	
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e2:SetCode(EVENT_ADJUST)
			e2:SetRange(LOCATION_MZONE)	
			e2:SetCondition(c100000270.sdcon3)
			e2:SetOperation(c100000270.operation)
			tc:RegisterEffect(e2)
			tc:RegisterFlagEffect(100000270,RESET_EVENT+0x1fe0000,0,1) 
			tc=g:GetNext()
		end
	end
end
function c100000270.sdfilter(c)
	return c:GetFlagEffect(83965310)==1
end
function c100000270.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local etc=c:GetEquipGroup()		
	if etc:GetCount()==0 then return end
	local ttc=etc:Filter(c100000270.sdfilter,nil)
	if ttc:GetCount()==0 then return end
	local code=ttc:GetFirst():GetOriginalCode()
	if c:IsFaceup() and c:GetFlagEffect(code)==0 then
		c:CopyEffect(code,RESET_EVENT+0x1fe0000+EVENT_CHAINING, 1)
		c:RegisterFlagEffect(code,RESET_EVENT+0x1fe0000+EVENT_CHAINING,0,1) 	
	end	
end