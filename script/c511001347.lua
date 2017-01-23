--Unfair Judge
function c511001347.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_BATTLE_END,0)
	e1:SetCondition(c511001347.condition)
	e1:SetCost(c511001347.cost)
	e1:SetTarget(c511001347.target)
	e1:SetOperation(c511001347.activate)
	c:RegisterEffect(e1)
	if not c511001347.global_check then
		c511001347.global_check=true
		c511001347[0]=false
		c511001347[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ATTACK_DISABLED)
		ge1:SetOperation(c511001347.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge4=Effect.CreateEffect(c)
		ge4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge4:SetCode(EVENT_PHASE_START+PHASE_BATTLE)
		ge4:SetOperation(c511001347.clear)
		Duel.RegisterEffect(ge4,0)
	end
end
function c511001347.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local p=tc:GetControler()
	c511001347[p]=true
end
function c511001347.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001347[0]=false
	c511001347[1]=false
end
function c511001347.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511001347[tp] and Duel.GetCurrentPhase()==PHASE_BATTLE
end
function c511001347.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)	
end
function c511001347.filter(c,atk,def)
	return c:IsFaceup() and c:GetAttack()<atk and c:GetAttack()<def
end
function c511001347.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local default=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,0,nil):GetMaxGroup(Card.GetAttack):GetFirst():GetAttack()+1
	local atkg=Duel.GetMatchingGroup(Card.IsPosition,tp,0,LOCATION_MZONE,nil,POS_FACEUP_ATTACK)
	local atk=default
	if atkg:GetCount()>0 then
		atk=atkg:GetSum(Card.GetAttack)
	end
	local defg=Duel.GetMatchingGroup(Card.IsPosition,tp,0,LOCATION_MZONE,nil,POS_FACEUP_DEFENSE)
	local def=default
	if defg:GetCount()>0 then
		def=defg:GetSum(Card.GetAttack)
	end
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001347.filter(chkc,atk,def) end
	if chk==0 then return Duel.IsExistingTarget(c511001347.filter,tp,LOCATION_MZONE,0,1,nil,atk,def) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511001347.filter,tp,LOCATION_MZONE,0,1,1,nil,atk,def)
end
function c511001347.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if Duel.GetTurnPlayer()==tp then
		Duel.SkipPhase(tp,PHASE_BATTLE,RESET_PHASE+PHASE_BATTLE,1)
	end
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_BP_TWICE)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		if Duel.GetTurnPlayer()==tp then
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_FIELD)
			e2:SetCode(EFFECT_CANNOT_ATTACK)
			e2:SetProperty(EFFECT_FLAG_OATH)
			e2:SetTargetRange(LOCATION_MZONE,0)
			e2:SetTarget(c511001347.ftarget)
			e2:SetLabel(tc:GetFieldID())
			e2:SetReset(RESET_PHASE+PHASE_BATTLE,2)
			Duel.RegisterEffect(e2,tp)
			--attack all
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_ATTACK_ALL)
			e3:SetValue(1)
			e3:SetReset(RESET_PHASE+PHASE_BATTLE,2)
			tc:RegisterEffect(e3)
		end
	end
end
function c511001347.ftarget(e,c)
	return e:GetLabel()~=c:GetFieldID()
end
