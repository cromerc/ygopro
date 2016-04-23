--愚者の種蒔き
function c100000114.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTarget(c100000114.target)
	e1:SetOperation(c100000114.operation)
	c:RegisterEffect(e1)	
	local e2=Effect.CreateEffect(c)		
	e2:SetDescription(aux.Stringid(100000114,0))
	e2:SetCategory(CATEGORY_DECKDES)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000114.condition)
	e2:SetTarget(c100000114.target)
	e2:SetOperation(c100000114.operation)
	c:RegisterEffect(e2)	
end
function c100000114.condition(e)
	return e:GetHandler():GetFlagEffect(100000114)==0
end
function c100000114.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x5)
end
function c100000114.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000114.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000114.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local tc=Duel.SelectTarget(tp,c100000114.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local ct=math.floor(tc:GetFirst():GetAttack()/300)
	Duel.SetTargetParam(ct)
	local res=Duel.TossCoin(tp,1)
	if res==0 then
		Duel.SetTargetPlayer(1-tp)			
		Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,1-tp,ct)
	else
		Duel.SetTargetPlayer(tp)		
		Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,ct)
	end		
	e:GetHandler():RegisterFlagEffect(100000114,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1) 
end
function c100000114.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.DiscardDeck(p,d,REASON_EFFECT)
end