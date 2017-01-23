--Timebreaker Magician (Anime)
function c511009369.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--double
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_MZONE)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCondition(c511009369.atkcon)
	e3:SetOperation(c511009369.atkop)
	c:RegisterEffect(e3)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
	c:RegisterEffect(e4)
	-- Adjust
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetCode(EVENT_ADJUST)
	e7:SetRange(LOCATION_PZONE)
	e7:SetOperation(c511009369.op)
	c:RegisterEffect(e7)
	-- copy scale
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(94585852,0))
	e8:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e8:SetProperty(EFFECT_FLAG_EVENT_PLAYER+EFFECT_FLAG_DAMAGE_STEP)
	e8:SetCode(511009363)
	e8:SetRange(LOCATION_PZONE)
	e8:SetTarget(c511009369.sctg)
	e8:SetOperation(c511009369.scop)
	c:RegisterEffect(e8)
end



function c511009369.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return eg:GetCount()==1 and eg:GetFirst()==c
		and c:GetSummonType()==SUMMON_TYPE_PENDULUM and c:IsPreviousLocation(LOCATION_HAND)
end
function c511009369.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(c:GetBaseAttack()*2)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
function c511009369.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetFlagEffect(511002005)==0 and ((c:GetPreviousLocation()~=LOCATION_SZONE 
	or (c:GetPreviousLocation()==LOCATION_SZONE and c:GetPreviousSequence()~=6
	or c:GetPreviousSequence()~=7))
	and (c:IsLocation(LOCATION_SZONE)
	and (c:GetSequence()==6 or c:GetSequence()==7)) )
	then 
	Duel.RaiseSingleEvent(e:GetHandler(),511009363,e,0,tp,tp,0)
	c:RegisterFlagEffect(511002005,RESET_EVENT+0x1fe0000,0,1)
	end
end
function c511009369.scfilter(c)
	return c:IsFaceup() and (c:GetSequence()==6 or c:GetSequence()==7)
end
function c511009369.sctg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c511009369.scfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009369.scfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511009369.scfilter,tp,LOCATION_SZONE,0,1,1,nil)
end
function c511009369.scop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LSCALE)
		e1:SetValue(tc:GetLeftScale())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_RSCALE)
		e1:SetValue(tc:GetRightScale())
		tc:RegisterEffect(e2)
	end
end
