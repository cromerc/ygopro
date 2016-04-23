--ドレイン・タイム
function c100000273.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c100000273.con)
	e1:SetOperation(c100000273.activate)
	c:RegisterEffect(e1)
end
function c100000273.filter(c)
	return c:GetCode()==83965310 and c:IsFaceup()
end
function c100000273.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000273.filter,e:GetHandler():GetControler(),LOCATION_MZONE,0,1,nil)
end
function c100000273.activate(e,tp,eg,ep,ev,re,r,rp)
	local op=Duel.SelectOption(tp,aux.Stringid(100000273,0),aux.Stringid(100000273,1),aux.Stringid(100000273,2),aux.Stringid(100000273,3),aux.Stringid(100000273,4))
	local res=RESET_PHASE+PHASE_END+RESET_OPPO_TURN,1
	local code=nil
	if op==0 then
		code=EFFECT_SKIP_DP
	elseif op==1 then
		code=EFFECT_SKIP_SP
	elseif op==2 then	
		if Duel.GetCurrentPhase()==PHASE_MAIN1 then 
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetCode(EFFECT_SKIP_M2)
			e1:SetTargetRange(1,0)
			e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
			Duel.RegisterEffect(e1,tp)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_SKIP_M1)
			e2:SetTargetRange(1,0)
			e2:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
			Duel.RegisterEffect(e2,1-tp)
		else 
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
			e1:SetCode(EFFECT_SKIP_M1)
			e1:SetTargetRange(1,1)
			e1:SetReset(RESET_PHASE+PHASE_END,2)
			Duel.RegisterEffect(e1,tp)
		end
	elseif op==3 then
		code=EFFECT_SKIP_BP
		if Duel.GetCurrentPhase()==PHASE_MAIN1 then res=RESET_PHASE+PHASE_BATTLE+RESET_OPPO_TURN,1 end
	end	
	if op~=2 and op~=4 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(code)
		e1:SetTargetRange(1,1)
		e1:SetReset(res)
		Duel.RegisterEffect(e1,tp)
	else
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_INITIAL)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetOperation(c100000273.operation)
		e1:SetReset(RESET_PHASE+PHASE_STANDBY,2)
		Duel.RegisterEffect(e1,tp)
	end
end
function c100000273.skcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()==PHASE_END
end
function c100000273.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_SKIP_TURN)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_STANDBY+RESET_OPPO_TURN)
	Duel.RegisterEffect(e1,tp)	
	local e2=e1:Clone()
	Duel.RegisterEffect(e2,1-tp)
end
