--Performapal Big Support
function c511009167.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511009167.condition)
	e1:SetTarget(c511009167.target)
	e1:SetOperation(c511009167.activate)
	c:RegisterEffect(e1)
	if not c511009167.global_check then
		c511009167.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c511009167.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c511009167.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if tc:GetFlagEffect(95100888)==0 then
			tc:RegisterFlagEffect(95100888,RESET_PHASE+PHASE_END,0,1)
		end
		tc=eg:GetNext()
	end
end
function c511009167.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511009167.filter(c)
	return c:GetFlagEffect(95100888)>0
end
function c511009167.eqfilter(c)
	return c:IsSetCard(0x9f) and c:IsAttackBelow(1000) and c:IsType(TYPE_MONSTER)
end
function c511009167.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
		if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingMatchingCard(c511009167.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c511009167.eqfilter,tp,LOCATION_HAND,0,1,nil) end
		local g=Duel.SelectTarget(tp,c511009167.filter,tp,LOCATION_MZONE,0,1,1,nil,tp)
		Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_HAND)
end
function c511009167.activate(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if not tc then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(12152769,2))
		local g=Duel.SelectMatchingCard(tp,c511009167.eqfilter,tp,LOCATION_HAND,0,1,1,nil)
		local ec=g:GetFirst()
		if ec then
			Duel.HintSelection(g)
			if not Duel.Equip(tp,ec,tc,true) then return end
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c511009167.eqlimit)
			e1:SetLabelObject(tc)
			ec:RegisterEffect(e1)
			local e2=Effect.CreateEffect(e:GetHandler())
			e2:SetType(EFFECT_TYPE_EQUIP)
			e2:SetProperty(EFFECT_FLAG_OWNER_RELATE+EFFECT_FLAG_IGNORE_IMMUNE)
			e2:SetCode(EFFECT_UPDATE_ATTACK)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			e2:SetValue(ec:GetTextAttack()*2)
			ec:RegisterEffect(e2)
			
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e3:SetRange(LOCATION_SZONE)
			e3:SetCode(EVENT_PHASE+PHASE_END)
			e3:SetCountLimit(1)
			e3:SetOperation(c511009167.tgop)
			e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			ec:RegisterEffect(e3)
		end
	end
		
function c511009167.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c511009167.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end
