--スピード・ワールド ２
function c110000000.initial_effect(c)
	c:EnableCounterPermit(0x91)
	c:SetCounterLimit(0x91,12)
	--Activate	
	local e1=Effect.CreateEffect(c)	
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCountLimit(1)
	e1:SetRange(0xf7)
	e1:SetOperation(c110000000.op)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)	
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetRange(LOCATION_SZONE)
	e2:SetOperation(c110000000.damop)
	c:RegisterEffect(e2)
	--add counter
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCountLimit(1)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EVENT_PHASE_START+PHASE_STANDBY)
	e3:SetOperation(c110000000.ctop)
	c:RegisterEffect(e3)
	--activation
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)	
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(1,1)
	e4:SetValue(c110000000.aclimit)
	Duel.RegisterEffect(e4,tp)	
	--unaffectable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IGNORE_IMMUNE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e5:SetValue(1)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetCode(EFFECT_IMMUNE_EFFECT)
	e6:SetValue(c110000000.ctcon2)
	c:RegisterEffect(e6)
	--cannot set
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_CANNOT_SSET)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetRange(LOCATION_SZONE)
	e7:SetTargetRange(1,1)
	e7:SetTarget(c110000000.aclimit2)
	c:RegisterEffect(e7)	
	--DAMAGE
	local e8=Effect.CreateEffect(c)
	e8:SetCategory(CATEGORY_DAMAGE)
	e8:SetDescription(aux.Stringid(110000000,0))
	e8:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e8:SetType(EFFECT_TYPE_IGNITION)
	e8:SetRange(LOCATION_SZONE)
	e8:SetCost(c110000000.cost1)
	e8:SetTarget(c110000000.tg1)
	e8:SetOperation(c110000000.op1)
	c:RegisterEffect(e8)
	--DRAW
	local e9=Effect.CreateEffect(c)
	e9:SetCategory(CATEGORY_DRAW)	
	e9:SetDescription(aux.Stringid(110000000,1))
	e9:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e9:SetType(EFFECT_TYPE_IGNITION)
	e9:SetRange(LOCATION_SZONE)	
	e9:SetCost(c110000000.cost2)
	e9:SetTarget(c110000000.tg2)
	e9:SetOperation(c110000000.op2)
	c:RegisterEffect(e9)	
	--DESTROY
	local ea=Effect.CreateEffect(c)
	ea:SetCategory(CATEGORY_DESTROY)
	ea:SetDescription(aux.Stringid(110000000,2))
	ea:SetProperty(EFFECT_FLAG_CARD_TARGET)
	ea:SetType(EFFECT_TYPE_IGNITION)
	ea:SetRange(LOCATION_SZONE)	
	ea:SetCost(c110000000.cost3)
	ea:SetTarget(c110000000.tg3)
	ea:SetOperation(c110000000.op3)
	c:RegisterEffect(ea)
	--
	local eb=Effect.CreateEffect(c)
	eb:SetType(EFFECT_TYPE_FIELD)
	eb:SetCode(EFFECT_CANNOT_TO_DECK)
	eb:SetRange(LOCATION_SZONE)
	eb:SetTargetRange(LOCATION_SZONE,0)
	eb:SetTarget(c110000000.tgn)
	c:RegisterEffect(eb)
	local ec=eb:Clone()
	ec:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(ec)
	local ed=eb:Clone()
	ed:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(ed)
	local ee=eb:Clone()
	ee:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(ee)
end
function c110000000.ctcon2(e,re)
	return not re:GetHandler():IsCode(100100103) and re:GetOwner()~=e:GetOwner()
end
function c110000000.filter(c)
	return c:GetCode()~=110000000
end
function c110000000.op(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	local tc2=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)	
	if tc==nil then
		Duel.MoveToField(e:GetHandler(),tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		if tc2==nil then
			local token=Duel.CreateToken(tp,110000000,nil,nil,nil,nil,nil,nil)		
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetCode(EFFECT_CHANGE_TYPE)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x1fc0000)
			e1:SetValue(TYPE_SPELL+TYPE_FIELD)
			token:RegisterEffect(e1)
			Duel.MoveToField(token,tp,1-tp,LOCATION_SZONE,POS_FACEUP,true)
		end
	else
		Duel.SendtoDeck(e:GetHandler(),nil,-2,REASON_EFFECT)
	end
	if e:GetHandler():GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
end
function c110000000.damop(e,tp,eg,ep,ev,re,r,rp)
	local c=re:GetHandler()
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and c~=e:GetHandler()
	 and c:GetControler()==e:GetHandler():GetControler() and not c:IsSetCard(0x200) then
		Duel.Damage(rp,2000,REASON_EFFECT)
	end
end
function c110000000.ctop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.IsPlayerAffectedByEffect(tp,100100090) then return end
	e:GetHandler():AddCounter(0x91,1)
end
function c110000000.aclimit(e,re)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and re:GetHandler():IsType(TYPE_FIELD)
end
function c110000000.aclimit2(e,c)
	return c:IsType(TYPE_FIELD)
end
function c110000000.cosilter(c)
	return c:IsSetCard(0x200) and not c:IsPublic()
end
function c110000000.cost1(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x91,4,REASON_COST)
	 and Duel.IsExistingMatchingCard(c110000000.cosilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	e:GetHandler():RemoveCounter(tp,0x91,4,REASON_COST)	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c110000000.cosilter,tp,LOCATION_HAND,0,1,1,nil)	
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
end
function c110000000.dafilter(c)
	return c:IsSetCard(0x200) and c:IsType(TYPE_SPELL)
end
function c110000000.tg1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c110000000.dafilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(800)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,800)
end
function c110000000.op1(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c110000000.cost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x91,7,REASON_COST)
	 and Duel.IsExistingMatchingCard(c110000000.cosilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	e:GetHandler():RemoveCounter(tp,0x91,7,REASON_COST)	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c110000000.cosilter,tp,LOCATION_HAND,0,1,1,nil)	
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
end
function c110000000.tg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,1) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c110000000.op2(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
function c110000000.cost3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanRemoveCounter(tp,0x91,10,REASON_COST)
	 and Duel.IsExistingMatchingCard(c110000000.cosilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	e:GetHandler():RemoveCounter(tp,0x91,10,REASON_COST)	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c110000000.cosilter,tp,LOCATION_HAND,0,1,1,nil)	
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
end
function c110000000.tg3(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_ONFIELD and Card.IsDestructable(chkc) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsDestructable,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c110000000.op3(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
function c110000000.tgn(e,c)
	return c==e:GetHandler()
end