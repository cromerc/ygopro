--Assault Blackwing - Kusanagi the Gathering Storm
function c511001969.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--Atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c511001969.valop)
	c:RegisterEffect(e1)
	--pierce
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e2)
end
function c511001969.valop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetSummonType()~=SUMMON_TYPE_SYNCHRO then return end
	local g=c:GetMaterial()
	local tc=g:GetFirst()
	local atk=0
	while tc do
		if tc:IsType(TYPE_SYNCHRO) and tc:IsSetCard(0x33) then
		local tatk=tc:GetTextAttack()
		if tatk<0 then tatk=0 end
		atk=atk+tatk
		end
		tc=g:GetNext()
	end
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(atk)
	e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
end
