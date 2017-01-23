--Assault Blackwing - Onimaru the Divine Swell
function c511002083.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetOperation(c511002083.atkop)
	c:RegisterEffect(e1)
	if not c511002083.global_check then
		c511002083.global_check=true
		c511002083[0]=0
		c511002083[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge1:SetOperation(c511002083.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002083.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002083.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:GetSummonType()==SUMMON_TYPE_SYNCHRO then
		c511002083[tc:GetSummonPlayer()]=c511002083[tc:GetSummonPlayer()]+1
	end
end
function c511002083.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002083[0]=0
	c511002083[1]=0
end
function c511002083.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c511002083[tp]
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct*1000)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
