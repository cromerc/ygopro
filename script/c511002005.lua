--Performapal Extra Shooter
function c511002005.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(95100067,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(511002005)
	e1:SetRange(LOCATION_PZONE)
	e1:SetTarget(c511002005.sctg)
	e1:SetOperation(c511002005.scop)
	c:RegisterEffect(e1)
	--lvup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(26082117,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetOperation(c511002005.lvop)
	c:RegisterEffect(e2)
	--lv change
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(95100067,2))
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetTarget(c511002005.lvtg2)
	e3:SetOperation(c511002005.lvop2)
	c:RegisterEffect(e3)
	if not c511002005.global_check then
		c511002005.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetOperation(c511002005.checkop)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002005.cfilter(c)
	if not c:IsLocation(LOCATION_SZONE) then return false end
	local seq=c:GetSequence()
	if seq~=6 and seq~=7 then return false end
	return c:GetFlagEffect(511002005+seq)==0 and (not c:IsPreviousLocation(LOCATION_SZONE) or c:GetPreviousSequence()~=seq)
end
function c511002005.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511002005.cfilter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	local tc=g:GetFirst()
	while tc do
		tc:ResetFlagEffect(511002005+13-tc:GetSequence())
		Duel.RaiseSingleEvent(tc,511002005,e,0,tp,tp,0)
		tc:RegisterFlagEffect(511002005+tc:GetSequence(),RESET_EVENT+0x1fe0000,0,1)
		tc=g:GetNext()
    end
end
function c511002005.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM)
end
function c511002005.sctg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_SZONE) and c511002005.filter(chkc) end
	if chk==0 then return Duel.IsExistingMatchingCard(c511002005.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511002005.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511002005.scop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=e:GetHandler()
	if tc and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LSCALE)
		e1:SetValue(tc:GetLeftScale())
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_RSCALE)
		e2:SetValue(tc:GetRightScale())
		tc:RegisterEffect(e2)
	end
end
function c511002005.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
function c511002005.seqfilter(c,e,tp,seq1,lv,e2)
	local lvtg=c:GetLevel()
	local seq=c:GetSequence()
	return (seq==1 or seq==2 or seq==3) and lvtg~=lv and (not e or c:IsRelateToEffect(e)) 
		and (not e2 or c:IsCanBeEffectTarget(e2))
		and Duel.IsExistingMatchingCard(c511002005.seqfilter2,tp,LOCATION_MZONE,0,1,nil,seq1,lv,seq)
end
function c511002005.seqfilter2(c,seq1,lv1,seq)
	local seq2=c:GetSequence()
	return c:IsFaceup() and c:GetLevel()==lv1 and ((seq1>seq and seq>seq2) or (seq2>seq and seq>seq1))
end
function c511002005.lvtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local seq=e:GetHandler():GetSequence()
	local lv=e:GetHandler():GetLevel()
	local ct1=Duel.GetMatchingGroupCount(c511002005.seqfilter,tp,LOCATION_MZONE,0,nil,nil,tp,seq,lv,nil)
	local ct2=Duel.GetMatchingGroupCount(c511002005.seqfilter,tp,LOCATION_MZONE,0,nil,nil,tp,seq,lv,e)
	if chkc then return false end
	if chk==0 then return ct1>0 and ct2>0 and ct1==ct2 end
	local g=Duel.GetMatchingGroup(c511002005.seqfilter,tp,LOCATION_MZONE,0,nil,nil,tp,seq,lv,e)
	Duel.SetTargetCard(g)
end
function c511002005.lvop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local seq=c:GetSequence()
	local lv=c:GetLevel()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(c511002005.seqfilter,nil,e,tp,seq,lv,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end

