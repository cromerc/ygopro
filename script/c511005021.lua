--Final Cross
--  By Shad3

local function getID()
	local str=string.match(debug.getinfo(2,'S')['source'],"c%d+%.lua")
	str=string.sub(str,1,string.len(str)-4)
	local scard=_G[str]
	local s_id=tonumber(string.sub(str,2))
	return scard,s_id
end

local scard,s_id=getID()

function scard.initial_effect(c)
	--Global effect
	if not scard.gl_chk then
		scard.gl_chk=true
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_TO_GRAVE)
		ge1:SetOperation(scard.reg_op)
		Duel.RegisterEffect(ge1,0)
	end
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetPreoerty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(scard.cd)
	e1:SetTarget(scard.tg)
	e1:SetOperation(scard.op)
	c:RegisterEffect(e1)
end

function scard.reg_op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(0,s_id)~=0 then return end
	local c=eg:GetFirst()
	while c do
		if c:IsType(TYPE_SYNCHRO) then
			Duel.RegisterFlagEffect(0,s_id,RESET_PHASE+PHASE_END,0,1)
			return
		end
		c=eg:GetNext()
	end
end

function scard.at_fil(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsFaceup() and c:GetAttackAnnouncedCount()>0 and c:GetFlagEffect(s_id)==0
end

function scard.cd(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(0,s_id)~=0
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and scard.at_fil(chkc)
	if chk==0 then return Duel.IsExistingTarget(scard.at_fil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp.scard.at_fil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		tc:RegisterFlagEffect(s_id,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EXTRA_ATTACK)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end