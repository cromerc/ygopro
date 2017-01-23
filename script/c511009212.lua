--Spell Search
--remade by MLD with tips from Shad3
function c511009212.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCondition(aux.FALSE)
	e1:SetTarget(c511009212.faketg)
	e1:SetOperation(c511009212.fakeop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PREDRAW)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511009212.condition)
	e2:SetTarget(c511009212.target)
	e2:SetOperation(c511009212.activate)
	c:RegisterEffect(e2)
	if not c511009212.global_check then
		c511009212.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetOperation(c511009212.checkop)
		ge1:SetCountLimit(1)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511009212.faketg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetTurnPlayer()~=tp and Duel.GetDrawCount(1-tp)>0 end
	local dt=Duel.GetDrawCount(1-tp)
	if dt~=0 then
		_replace_count=0
		_replace_max=dt
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetTargetRange(0,1)
		e1:SetReset(RESET_PHASE+PHASE_DRAW)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511009212.fakeop(e,tp,eg,ep,ev,re,r,rp)
	_replace_count=_replace_count+1
	if _replace_count<=_replace_max then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(1-tp,c511009212.afilter,1-tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(tp,g)
		else
			local dg=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
			Duel.ConfirmCards(tp,dg)
			Duel.ShuffleDeck(1-tp)
		end
	end
end
function c511009212.filter(c)
	return c:GetOriginalCode()==511009212
end
function c511009212.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009212.filter,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	--local g2=Group.CreateGroup()
	local tc=g:GetFirst()
	while tc do
		local te=tc:GetActivateEffect()
		te:SetCondition(aux.TRUE)
		if te:IsActivatable(tc:GetControler()) and Duel.SelectYesNo(tc:GetControler(),aux.Stringid(28265983,0)) then
			Duel.ChangePosition(tc,POS_FACEUP)
			--g2:AddCard(tc)
		end
		te:SetCondition(aux.FALSE)
		tc=g:GetNext()
	end
	--[[if g2:GetCount()>0 then
		Duel.RaiseEvent(g2,EVENT_PREDRAW,e,REASON_EFFECT,Duel.GetTurnPlayer(),Duel.GetTurnPlayer(),0)
	end]]
end
function c511009212.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetDrawCount(1-tp)>0
end
function c511009212.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return true end
	e:SetType(EFFECT_TYPE_ACTIVATE)
	local dt=Duel.GetDrawCount(1-tp)
	if dt~=0 then
		_replace_count=0
		_replace_max=dt
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetTargetRange(0,1)
		e1:SetReset(RESET_PHASE+PHASE_DRAW)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
	end
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_END)
	e2:SetLabelObject(e)
	e2:SetOperation(c511009212.resetop)
	e2:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e2,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,1-tp,LOCATION_DECK)
end
function c511009212.resetop(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
end
function c511009212.afilter(c)
	return c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c511009212.activate(e,tp,eg,ep,ev,re,r,rp)
	_replace_count=_replace_count+1
	if _replace_count<=_replace_max then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(1-tp,c511009212.afilter,1-tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(tp,g)
		else
			local dg=Duel.GetFieldGroup(tp,0,LOCATION_DECK)
			Duel.ConfirmCards(tp,dg)
			Duel.ShuffleDeck(1-tp)
		end
	end
end
