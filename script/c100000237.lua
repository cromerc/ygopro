--デルタ・バリア
function c100000237.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c100000237.activate)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetRange(LOCATION_SZONE)
	e2:SetType(EFFECT_TYPE_QUICK_O+EFFECT_TYPE_FIELD)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetCountLimit(1)
	e2:SetCondition(c100000237.con)
	e2:SetCost(c100000237.cost)
	e2:SetOperation(c100000237.op)
	c:RegisterEffect(e2)
	Duel.AddCustomActivityCounter(100000237,ACTIVITY_CHAIN,aux.FALSE)
end
function c100000237.filter(c,tp)
	local te=c:GetActivateEffect()
	if not te then return false end
	return c:IsCode(100000237) and (te:IsActivatable(tp) or (c:IsControler(1-tp) and te:IsActivatable(1-tp)))
end 
function c100000237.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	local g=Duel.GetMatchingGroup(c100000237.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,nil,tp)
	if ft>0 and g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(39910367,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(15248873,0))
		local sg=g:Select(tp,1,ft,nil)
		local tc=sg:GetFirst()
		while tc do
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			local te=tc:GetActivateEffect()
			local tep=tc:GetControler()
			Duel.RaiseEvent(tc,EVENT_CHAIN_SOLVED,tc:GetActivateEffect(),0,tp,tp,Duel.GetCurrentChain())
			tc=sg:GetNext()
		end
	end
end
function c100000237.cfilter(c)
	return c:IsFaceup() and c:IsCode(100000237)
end 
function c100000237.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)>0 and Duel.GetMatchingGroupCount(c100000237.cfilter,tp,LOCATION_ONFIELD,0,nil)==3 
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0
end
function c100000237.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(100000237,tp,ACTIVITY_CHAIN)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,0)
	e1:SetValue(aux.TRUE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c100000237.op(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e1:SetOperation(c100000237.damop)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE)
	Duel.RegisterEffect(e1,tp)
end
function c100000237.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end
