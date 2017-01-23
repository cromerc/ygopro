--Trap Buster
function c110000105.initial_effect(c)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_SZONE)
	e3:SetTarget(c110000105.distg)
	c:RegisterEffect(e3)
	--disable effect
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_CHAIN_SOLVING)
	e4:SetRange(LOCATION_MZONE)
	e4:SetOperation(c110000105.disop)
	c:RegisterEffect(e4)
	if not c110000105.global_check then
		c110000105.global_check=true
		if Duel.GetFlagEffect(0,110000104)==0 and Duel.GetFlagEffect(1,110000104)==0 then
			Duel.RegisterFlagEffect(0,110000104,0,0,1)
			Duel.RegisterFlagEffect(1,110000104,0,0,1)
			--cannot attack
			local ge1=Effect.CreateEffect(c)
			ge1:SetType(EFFECT_TYPE_FIELD)
			ge1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			ge1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
			ge1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
			ge1:SetCondition(c110000105.atkcon)
			ge1:SetTarget(c110000105.atktg)
			Duel.RegisterEffect(ge1,0)
			--check
			local ge2=Effect.CreateEffect(c)
			ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			ge2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			ge2:SetCode(EVENT_ATTACK_ANNOUNCE)
			ge2:SetOperation(c110000105.checkop)
			ge2:SetLabelObject(ge1)
			Duel.RegisterEffect(ge2,0)
			--change attack target
			local ge3=Effect.CreateEffect(c)
			ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			ge3:SetCode(EVENT_BE_BATTLE_TARGET)
			ge3:SetCondition(c110000105.atcon)
			ge3:SetOperation(c110000105.atop)
			Duel.RegisterEffect(ge3,0)
			local ge4=ge3:Clone()
			Duel.RegisterEffect(ge4,1)
		end
	end
end
function c110000105.atkcon(e)
	return Duel.GetFlagEffect(e:GetHandlerPlayer(),110000103)~=0 and Duel.GetFlagEffect(1-e:GetHandlerPlayer(),110000103)~=0
end
function c110000105.atktg(e,c)
	return c:GetFieldID()~=e:GetLabel() and c:IsType(0x10000000)
end
function c110000105.checkop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if not a:IsType(0x10000000) then return end
	if Duel.GetFlagEffect(tp,110000103)~=0 and Duel.GetFlagEffect(1-tp,110000103)~=0 then return end
	local fid=eg:GetFirst():GetFieldID()
	Duel.RegisterFlagEffect(tp,110000103,RESET_PHASE+PHASE_END,0,1)
	Duel.RegisterFlagEffect(1-tp,110000103,RESET_PHASE+PHASE_END,0,1)
	e:GetLabelObject():SetLabel(fid)
end
function c110000105.atcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at:IsFaceup() and at:IsControler(tp) and at:IsType(0x10000000)
end
function c110000105.filter(c)
	return c:IsFaceup() and c:IsType(0x10000000)
end
function c110000105.atop(e,tp,eg,ep,ev,re,r,rp)
	local atg=Duel.GetAttacker():GetAttackableTarget()
	local d=Duel.GetAttackTarget()
	if atg:IsExists(c110000105.filter,1,d) and Duel.SelectYesNo(tp,aux.Stringid(21558682,0)) then
		local g=atg:FilterSelect(tp,c110000105.filter,1,1,d)
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(g:GetFirst())
	end
end
function c110000105.cfilter(c,tp)
	return c:IsFaceup() and c:IsType(0x10000000) and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
end
function c110000105.distg(e,c)
	return c:GetCardTargetCount()>0 and c:IsType(TYPE_TRAP) 
		and c:GetCardTarget():IsExists(c110000105.cfilter,1,nil,e:GetHandlerPlayer())
end
function c110000105.disop(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsActiveType(TYPE_TRAP) then return end
	if not re:IsHasProperty(EFFECT_FLAG_CARD_TARGET) then return end
	local g=Duel.GetChainInfo(ev,CHAININFO_TARGET_CARDS)
	if not g or not g:IsExists(c110000105.cfilter,1,nil,tp) then return end
	Duel.NegateEffect(ev)
end
