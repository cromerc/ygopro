--Power Stream
function c511001424.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001424.target)
	e1:SetOperation(c511001424.activate)
	c:RegisterEffect(e1)
	if not c511001424.global_check then
		c511001424.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c511001424.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511001424.checkop(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	if ph<=PHASE_MAIN1 or ph>=PHASE_MAIN2 then return end
	local tc=eg:GetFirst()
	while tc do
		if tc:IsFaceup() and tc:GetFlagEffect(511001424)==0 then
			tc:RegisterFlagEffect(511001424,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
		end
		tc=eg:GetNext()
	end
end
function c511001424.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER) and c:IsType(TYPE_XYZ) and c:GetFlagEffect(511001424)>0
end
function c511001424.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511001424.filter(chkc) end
	if chk==0 then return e:IsHasType(EFFECT_TYPE_ACTIVATE) 
		and Duel.IsExistingTarget(c511001424.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001424.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c511001424.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) and c:IsRelateToEffect(e) then
		c:CancelToGrave()
		Duel.Overlay(tc,Group.FromCards(c))
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_DAMAGE_CALCULATING)
		e1:SetOperation(c511001424.atkop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
function c511001424.atkop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if a~=e:GetHandler() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(1000)
	a:RegisterEffect(e1)
end
