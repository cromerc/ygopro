--BF－隠れ蓑のスチーム
function c511002726.initial_effect(c)
	--token
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9047460,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetTarget(c511002726.tktg)
	e1:SetOperation(c511002726.tkop)
	c:RegisterEffect(e1)
end
function c511002726.tktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,9047461,0,0x4011,100,100,3,RACE_AQUA,ATTRIBUTE_WIND) end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511002726.tkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	if Duel.IsPlayerCanSpecialSummonMonster(tp,9047461,0,0x4011,100,100,3,RACE_AQUA,ATTRIBUTE_WIND) then
		local token=Duel.CreateToken(tp,9047461)
		Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EVENT_PHASE+PHASE_END)
		e1:SetOperation(c511002726.desop)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetCountLimit(1)
		token:RegisterEffect(e1)
		--register
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetRange(LOCATION_MZONE)	
		e2:SetOperation(c511002726.operation)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_DAMAGE_STEP)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(511000883)
		e3:SetCondition(c511002726.atkcon)
		e3:SetOperation(c511002726.atkop)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		token:RegisterEffect(e3)
	end
end
function c511002726.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
function c511002726.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()	
	local g=Duel.GetMatchingGroup(nil,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:IsFaceup() and tc:GetFlagEffect(511000883)==0 then
			local e1=Effect.CreateEffect(c)	
			e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
			e1:SetCode(EVENT_CHAIN_SOLVED)
			e1:SetRange(LOCATION_MZONE)
			e1:SetLabel(tc:GetAttack())
			e1:SetOperation(c511002726.op)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511000883,RESET_EVENT+0x1fe0000,0,1) 	
		end	
		tc=g:GetNext()
	end		
end
function c511002726.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==c:GetAttack() then return end
	if e:GetLabel()>c:GetAttack() then
		local val=e:GetLabel()-c:GetAttack()
		Duel.RaiseEvent(c,511000883,re,REASON_EFFECT,rp,tp,val)
	end
	e:SetLabel(c:GetAttack())
end
function c511002726.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	return ec:IsControler(1-tp) and ev>0 and ec:GetAttack()<=0
end
function c511002726.atkop(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	Duel.Remove(ec,POS_FACEUP,REASON_EFFECT)
end
