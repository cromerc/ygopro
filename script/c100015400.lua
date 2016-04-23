--
function c100015400.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetHintTiming(0,TIMING_END_PHASE)	
	e1:SetCondition(c100015400.con)
	e1:SetTarget(c100015400.target)
	e1:SetOperation(c100015400.operation)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCondition(c100015400.con)
	e2:SetTarget(c100015400.target)
	e2:SetOperation(c100015400.operation)
	c:RegisterEffect(e2)
	--Activate
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e3)
end
function c100015400.filter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x400) and c:IsSetCard(0x45) 
end
function c100015400.con(e,tp,eg,ep,ev,re,r,rp,chk)
	return eg:IsExists(c100015400.filter,1,nil,tp) and 
	(Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) or
	(Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_DECK,1,nil) and Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_DECK,0,1,nil)) or
	 Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil))
	and e:GetHandler():GetFlagEffect(100015400)==0
end
function c100015400.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsStatus(STATUS_CHAINING) end
	
end
function c100015400.operation(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g1=nil
	local g2=nil	
	local t={}
	local p=1
	if Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) then t[p]=aux.Stringid(100015400,0) p=p+1 end
	if Duel.IsExistingTarget(Card.IsAbleToRemove,tp,0,LOCATION_DECK,1,nil) 
	and Duel.IsExistingTarget(Card.IsAbleToRemove,tp,LOCATION_DECK,0,1,nil) then t[p]=aux.Stringid(100015400,1) p=p+1 end
	if Duel.IsExistingTarget(Card.IsAbleToHand,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil) then t[p]=aux.Stringid(100015400,2) p=p+1 end
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(100015400,3))
	local sel=Duel.SelectOption(1-tp,table.unpack(t))+1
	local opt=t[sel]-aux.Stringid(100015400,0)
	if opt==0 then 
		g1=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=g1:Select(tp,1,1,nil)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
		e:GetHandler():RegisterFlagEffect(100015400,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	elseif opt==1 then 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		g1=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_DECK,0,1,1,nil)
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_REMOVE)
		g2=Duel.SelectMatchingCard(1-tp,Card.IsAbleToRemove,1-tp,LOCATION_DECK,0,1,1,nil)		
		g1:Merge(g2)
		Duel.Remove(g1,POS_FACEUP,REASON_EFFECT)
		e:GetHandler():RegisterFlagEffect(100015400,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	else	
		g1=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local sg=g1:Select(tp,1,1,nil)
		Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
		e:GetHandler():RegisterFlagEffect(100015400,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end	
end