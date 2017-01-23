--One Two Jump
function c511001341.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511001341.condition)
	e1:SetTarget(c511001341.target)
	e1:SetOperation(c511001341.activate)
	c:RegisterEffect(e1)
	if not c511001341.global_check then
		c511001341.global_check=true
		c511001341[0]=Group.CreateGroup()
		c511001341[0]:KeepAlive()
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLE_DESTROYING)
		ge1:SetOperation(c511001341.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge4=Effect.CreateEffect(c)
		ge4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge4:SetCode(EVENT_PHASE_START+PHASE_BATTLE)
		ge4:SetOperation(c511001341.clear)
		Duel.RegisterEffect(ge4,0)
	end
end
function c511001341.checkop(e,tp,eg,ep,ev,re,r,rp)
	if eg:GetCount()~=1 then return end
	local tc=eg:GetFirst()
	if tc:IsRelateToBattle() and tc:IsFaceup() then
		if tc:GetFlagEffect(511001341)>0 then
			c511001341[0]:AddCard(tc)
		else
			tc:RegisterFlagEffect(511001341,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
		end
	end
end
function c511001341.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001341[0]:Clear()
end
function c511001341.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return ph>=0x08 and ph<=0x20 and (ph~=PHASE_DAMAGE or not Duel.IsDamageCalculated())
end
function c511001341.filter(c,e,tp)
	return c:IsCanBeEffectTarget(e) and c:IsFaceup() and c:IsControler(tp)
end
function c511001341.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=c511001341[0]:Filter(c511001341.filter,nil,e,tp)
	if chkc then return false end
	if chk==0 then return g:GetCount()>0 and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local sg=g:Select(tp,1,1,nil)
	Duel.SetTargetCard(sg)
end
function c511001341.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
		local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
		if g:GetCount()>0 then
			Duel.HintSelection(g)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK_FINAL)
			e1:SetValue(g:GetFirst():GetAttack()/2)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
			g:GetFirst():RegisterEffect(e1)
			if Duel.SelectYesNo(tp,aux.Stringid(17313545,0)) then
				Duel.CalculateDamage(tc,g:GetFirst())
			end
		end
	end
end
